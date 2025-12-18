#if canImport(Combine)

import Foundation
import Combine

/// A property wrapper that combines the functionality of `@Published` and `UserDefaults` storage.
/// It persists a `Codable` value in `UserDefaults` and publishes changes to that value.
///
/// `PublishedCodableSettingStorage` is designed for use in scenarios where you want to store a value in
/// `UserDefaults` and also broadcast changes to that value using Combine's `@Published` mechanism.
/// This is particularly useful for settings or preferences in SwiftUI applications.
///
/// Usage:
/// ```
/// class SettingsViewModel: ObservableObject {
///     @PublishedCodableSettingStorage(key: "mySettingKey") var mySetting: String
/// }
/// ```
///
/// In this example, `mySetting` is stored in `UserDefaults` and changes to it will be published.
@propertyWrapper @MainActor
public struct PublishedCodableSettingStorage<Value> where Value: Codable {
    private let key: String
    private var dataHash: Int
    private var value: Value
    private let userDefaults: UserDefaults
    
    public init(wrappedValue: Value, key: String, userDefaults: UserDefaults = .standard) {
        self.key = key
        self.dataHash = 0
        self.value = wrappedValue
        self.userDefaults = userDefaults
        self.updateValue()
    }
    
    mutating private func updateValue() {
        guard let data = userDefaults.data(forKey: key) else { return }
        
        let newHash = data.hashValue
        if newHash == dataHash { return }
        dataHash = newHash
        
        guard let value = try? JSONDecoder().decode(Value.self, from: data) else {
            assertionFailure()
            return
        }
        self.value = value
    }
    
    // - MARK: Publishable

    private var publisher: Publisher?
    internal var objectWillChange: ObservableObjectPublisher?
    
    /// The property that can be accessed with the `$` syntax and allows access to
    /// the `Publisher`
    public var projectedValue: Publisher {
        mutating get {
            if let publisher = publisher {
                return publisher
            }
            let publisher = Publisher(value)
            self.publisher = publisher
            return publisher
        }
    }
    
    @available(*, unavailable, message: "@Published is only available on properties of classes")
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    public static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, PublishedCodableSettingStorage<Value>>
    ) -> Value {
        get {
            object[keyPath: storageKeyPath].updateValue()
            return object[keyPath: storageKeyPath].value
        }
        set {
            Task { @MainActor in
                (object.objectWillChange as! ObservableObjectPublisher).send()
                object[keyPath: storageKeyPath].objectWillChange?.send()
                object[keyPath: storageKeyPath].publisher?.subject.send(newValue)
            }
            object[keyPath: storageKeyPath].value = newValue
            
            let encoded = try! JSONEncoder().encode(newValue)
            object[keyPath: storageKeyPath].dataHash = encoded.hashValue
            object[keyPath: storageKeyPath].userDefaults.set(encoded, forKey: object[keyPath: storageKeyPath].key)
        }
        // TODO: Benchmark and explore a possibility to use _modify
    }
}

public extension PublishedCodableSettingStorage {
    
    /// A publisher for properties marked with the `@BackrgoundPublished` attribute.
    struct Publisher: Combine.Publisher {
        public typealias Output = Value
        public typealias Failure = Never
        
        fileprivate let subject: CurrentValueSubject<Value, Never>

        fileprivate init(_ output: Output) {
            subject = .init(output)
        }

        public func receive<Downstream: Subscriber>(subscriber: Downstream)
            where Downstream.Input == Value, Downstream.Failure == Never
        {
            subject.subscribe(subscriber)
        }
    }
}

#endif
