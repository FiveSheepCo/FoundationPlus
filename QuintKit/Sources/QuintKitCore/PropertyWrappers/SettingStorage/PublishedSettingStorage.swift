#if canImport(Combine)

import Foundation
import Combine

/// A property wrapper that combines the functionality of `@Published` and `UserDefaults` storage.
/// It persists a value in `UserDefaults` and publishes changes to that value.
///
/// `PublishedSettingStorage` is designed for use in scenarios where you want to store a value in
/// `UserDefaults` and also broadcast changes to that value using Combine's `@Published` mechanism.
/// This is particularly useful for settings or preferences in SwiftUI applications.
///
/// Usage:
/// ```
/// class SettingsViewModel: ObservableObject {
///     @PublishedSettingStorage(key: "mySettingKey") var mySetting: String
/// }
/// ```
///
/// In this example, `mySetting` is stored in `UserDefaults` and changes to it will be published.
@propertyWrapper
public struct PublishedSettingStorage<Value> {
    private let explicitKey: String?
    private var initialValue: Value
    private let userDefaults: UserDefaults
    
    public init(wrappedValue: Value, key: String? = nil, userDefaults: UserDefaults = .standard) {
        self.explicitKey = key
        self.initialValue = wrappedValue
        self.userDefaults = userDefaults
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
            let publisher = Publisher(initialValue)
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
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, PublishedSettingStorage<Value>>
    ) -> Value {
        get {
            let storage = object[keyPath: storageKeyPath]
            
            // IMPORTANT: If your app crashes here, it means you are trying to use a non-explicit key and do not meet the requirement for doing so. The requirement is: Your property has to be exposed to Objective-C (`@objc @PublishedSettingStorage`).
            let key = storage.explicitKey ?? NSExpression(forKeyPath: wrappedKeyPath).keyPath
            return storage.userDefaults.object(forKey: key) as? Value ?? storage.initialValue
        }
        set {
            // IMPORTANT: If your app crashes here, it means you are trying to use a non-explicit key and do not meet the requirement for doing so. The requirement is: Your property has to be exposed to Objective-C (`@objc @PublishedSettingStorage`).
            let key = object[keyPath: storageKeyPath].explicitKey ?? NSExpression(forKeyPath: wrappedKeyPath).keyPath
            
            Task { @MainActor in
                (object.objectWillChange as! ObservableObjectPublisher).send()
                object[keyPath: storageKeyPath].objectWillChange?.send()
                object[keyPath: storageKeyPath].publisher?.subject.send(newValue)
            }
            object[keyPath: storageKeyPath].userDefaults.set(newValue, forKey: key)
        }
        // TODO: Benchmark and explore a possibility to use _modify
    }
}

public extension PublishedSettingStorage {
    
    /// A publisher for properties marked with the `@PublishedSettingStorage` attribute.
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
