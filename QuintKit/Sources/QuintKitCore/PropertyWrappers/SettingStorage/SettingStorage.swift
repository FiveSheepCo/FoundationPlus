#if canImport(Combine)

import Foundation
import Combine

/// A property wrapper that provides persistent storage for a value in `UserDefaults` and publishes changes.
///
/// `SettingStorage` is designed to store and retrieve values from `UserDefaults` while also providing
/// a Combine publisher to observe changes to these values. It's useful for settings or preferences in
/// an app where changes need to be observed and persisted across app launches.
///
/// Usage:
/// ```
/// class SettingsViewModel: ObservableObject {
///     @SettingStorage(key: "mySettingKey") var mySetting: String
/// }
/// ```
///
/// In this example, `mySetting` will be stored in and retrieved from `UserDefaults`, and any changes
/// to it will be published to subscribers.
@propertyWrapper
public struct SettingStorage<Value>: Publishable {
    private let key: String
    private var value: Value
    private let userDefaults: UserDefaults
    
    public init(wrappedValue: Value, key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.value = (userDefaults.object(forKey: key) as? Value) ?? wrappedValue
        self.userDefaults = userDefaults
    }
    
    public var wrappedValue: Value {
        get {
            return value
        }
        set {
            value = newValue
            userDefaults.set(value, forKey: key)
        }
    }
    
    // - MARK: Publishable
    
    public var publisher: PublishablePublisher<Value>?
    public var objectWillChange: ObservableObjectPublisher?
}

#endif
