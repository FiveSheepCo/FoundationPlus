#if canImport(Combine)

import Combine

/// A publisher for properties marked with the `@Published` attribute.
public struct PublishablePublisher<Value>: Combine.Publisher {
    public typealias Output = Value
    public typealias Failure = Never
    
    public let subject: Combine.CurrentValueSubject<Value, Never>
    
    public init(_ output: Output) {
        subject = .init(output)
    }
    
    public func receive<Downstream: Subscriber>(subscriber: Downstream)
    where Downstream.Input == Value, Downstream.Failure == Never
    {
        subject.subscribe(subscriber)
    }
}

#endif
