#if canImport(Combine)

import Combine

typealias CombinePublisher = Combine.Publisher

/// A property wrapper for `Equatable` values that provides a Combine publisher for changes to the value.
///
/// The `EquatablePublished` struct ensures that updates are only published when the new value is different
/// from the current value, leveraging the `Equatable` conformance of the wrapped value. This is useful
/// in scenarios where you want to minimize unnecessary updates and only react to meaningful changes.
///
/// Usage:
/// ```swift
/// class MyClass: ObservableObject {
///     @EquatablePublished var myProperty: MyEquatableType
/// }
/// ```
///
/// In this example, `myProperty` will only trigger updates to any subscribers when the value actually changes.
@propertyWrapper
public struct EquatablePublished<Value: Equatable> {
    private var publisher: Publisher?
    private var storage: Storage
    
    private enum Storage {
        case value(Value)
        case publisher(Publisher)
    }

    /// Creates an `EquatablePublished` instance with the provided initial value.
    /// - Parameter initialValue: The initial value to be assigned to the property.
    @inlinable // trivially forwarding
    public init(initialValue: Value) {
        self.init(wrappedValue: initialValue)
    }

    /// Initializes the storage of the `EquatablePublished` property as well as the corresponding `Publisher`.
    /// - Parameter wrappedValue: The initial value of the `EquatablePublished` property.
    public init(wrappedValue: Value) {
        self.storage = .value(wrappedValue)
    }
    
    /// The property that can be accessed with the `$` syntax and allows access to
    /// the `Publisher`
    public var projectedValue: Publisher {
        mutating get {
            switch storage {
                case .value(let value):
                    let publisher = Publisher(value)
                    storage = .publisher(publisher)
                    return publisher
                case .publisher(let publisher):
                    return publisher
            }
        }
        set {
            switch storage {
                case .value(let value):
                    storage = .publisher(Publisher(value))
                case .publisher:
                    break
            }
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
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, EquatablePublished<Value>>
    ) -> Value {
        get {
            switch object[keyPath: storageKeyPath].storage {
                case .value(let value):
                    value
                case .publisher(let publisher):
                    publisher.subject.value
            }
        }
        set {
            switch object[keyPath: storageKeyPath].storage {
                case .value(let value):
                    if value == newValue { return }
                    object[keyPath: storageKeyPath].storage = .publisher(Publisher(newValue))
                case .publisher(let publisher):
                    if publisher.subject.value == newValue { return }
                    publisher.subject.value = newValue
            }
            (object.objectWillChange as! ObservableObjectPublisher).send()
        }
    }
}

public extension EquatablePublished {
    
    /// A publisher for properties marked with the `@EquatablePublished` attribute.
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
