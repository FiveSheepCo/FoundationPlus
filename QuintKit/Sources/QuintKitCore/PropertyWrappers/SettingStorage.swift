#if canImport(Combine)

import Foundation
import Combine

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
