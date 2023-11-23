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

    /// Creates an `EquatablePublished` instance with the provided initial value.
    /// - Parameter initialValue: The initial value to be assigned to the property.
    @inlinable // trivially forwarding
    public init(initialValue: Value) {
        self.init(wrappedValue: initialValue)
    }

    /// Initializes the storage of the `EquatablePublished` property as well as the corresponding `Publisher`.
    /// - Parameter wrappedValue: The initial value of the `EquatablePublished` property.
    public init(wrappedValue: Value) {
        value = wrappedValue
    }

    /// A publisher for properties marked with the `@EquatablePublished` attribute.
    public struct Publisher: CombinePublisher {

        public typealias Output = Value

        public typealias Failure = Never

        public func receive<Downstream: Subscriber>(subscriber: Downstream)
            where Downstream.Input == Value, Downstream.Failure == Never
        {
            subject.subscribe(subscriber)
        }

        fileprivate let subject: CurrentValueSubject<Value, Never>

        fileprivate init(_ output: Output) {
            subject = .init(output)
        }
    }

    private var value: Value

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
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, EquatablePublished<Value>>
    ) -> Value {
        get {
            return object[keyPath: storageKeyPath].value
        }
        set {
            guard object[keyPath: storageKeyPath].value != newValue else { return }
            
            (object.objectWillChange as! ObservableObjectPublisher).send()
            object[keyPath: storageKeyPath].value = newValue
        }
    }
}

#endif
