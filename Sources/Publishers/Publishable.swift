#if canImport(Combine)

import Combine

public protocol Publishable {
    associatedtype Value
    
    var wrappedValue: Value { get set }
    var publisher: PublishablePublisher<Value>? { get set }
    var objectWillChange: ObservableObjectPublisher? { get set }
}

public extension Publishable {
    
    /// The property that can be accessed with the `$` syntax and allows access to
    /// the `Publisher`
    var projectedValue: PublishablePublisher<Value> {
        mutating get {
            if let publisher = publisher {
                return publisher
            }
            let publisher = PublishablePublisher(wrappedValue)
            self.publisher = publisher
            return publisher
        }
    }
    
    static subscript<EnclosingSelf: ObservableObject>(
        _enclosingInstance object: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            return object[keyPath: storageKeyPath].wrappedValue
        }
        set {
            (object.objectWillChange as! ObservableObjectPublisher).send()
            object[keyPath: storageKeyPath].objectWillChange?.send()
            object[keyPath: storageKeyPath].publisher?.subject.send(newValue)
            object[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
}

#endif
