#if canImport(Combine)

import Foundation
import Combine

/// A property wrapper that provides persistent storage for a `Codable` value in `UserDefaults` and publishes changes.
///
/// `CodableSettingStorage` is designed to store and retrieve values from `UserDefaults` while also providing
/// a Combine publisher to observe changes to these values. It's useful for settings or preferences in
/// an app where changes need to be observed and persisted across app launches.
///
/// Usage:
/// ```
/// class SettingsViewModel: ObservableObject {
///     @CodableSettingStorage(key: "mySettingKey") var mySetting: String
/// }
/// ```
///
/// In this example, `mySetting` will be stored in and retrieved from `UserDefaults`, and any changes
/// to it will be published to subscribers.
@propertyWrapper
public struct CodableSettingStorage<Value>: Publishable where Value: Codable {
    private let key: String
    private var value: Value
    private let userDefaults: UserDefaults
    
    public init(wrappedValue: Value, key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        if let data = userDefaults.data(forKey: key),
           let value = try? JSONDecoder().decode(Value.self, from: data) {
            self.value = value
        } else {
            self.value = wrappedValue
        }
        self.userDefaults = userDefaults
    }
    
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue
            userDefaults.set(try! JSONEncoder().encode(value), forKey: key)
        }
    }
    
    // - MARK: Publishable
    
    public var publisher: PublishablePublisher<Value>?
    public var objectWillChange: ObservableObjectPublisher?
}

#endif
