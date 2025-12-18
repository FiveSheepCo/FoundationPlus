#if canImport(Combine)

import Foundation
import Combine

/// A property wrapper that provides a Combine publisher for its changes, ensuring updates are always published on the main thread, even if called from a background thread.
///
/// The `BackgroundPublished` property wrapper is designed to be used within `ObservableObject` classes.
/// It automatically publishes changes to its value on the main thread, which is useful in scenarios
/// where you want to update the UI from within a background thread.
///
/// Usage:
/// ```
/// class MyClass: ObservableObject {
///     @BackgroundPublished var myProperty: MyType
/// }
/// ```
///
/// In this example, changes to `myProperty` will automatically trigger updates on the main thread, even if called from a background thread.
@propertyWrapper @MainActor
public struct BackgroundPublished<Value> {
    
    private var value: Value
    private var publisher: Publisher?
    internal var objectWillChange: ObservableObjectPublisher?

    @inlinable // trivially forwarding
    public init(initialValue: Value) {
        self.init(wrappedValue: initialValue)
    }

    /// Initialize the storage of the `BackrgoundPublished` property as well as the corresponding
    /// `Publisher`.
    public init(wrappedValue: Value) {
        value = wrappedValue
    }

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

    // swiftlint:disable let_var_whitespace
    @available(*, unavailable, message: "@Published is only available on properties of classes")
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() } // swiftlint:disable:this unused_setter_value
    }
    
    // swiftlint:enable let_var_whitespace
    public static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, BackgroundPublished<Value>>
    ) -> Value {
        get {
            return object[keyPath: storageKeyPath].value
        }
        set {
            object[keyPath: storageKeyPath].value = newValue
            Task { @MainActor in
                (object.objectWillChange as! ObservableObjectPublisher).send()
                object[keyPath: storageKeyPath].objectWillChange?.send()
                object[keyPath: storageKeyPath].publisher?.subject.send(newValue)
            }
        }
        // TODO: Benchmark and explore a possibility to use _modify
    }
}

public extension BackgroundPublished {
    
    /// A publisher for properties marked with the `@BackgroundPublished` attribute.
    struct Publisher: CombinePublisher {
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
