import Foundation

/// Identity function returning its value as-is.
private func identity<T>(_ value: T) -> T { value }

public extension Sequence {
    
    /// Returns an array containing the non-nil values of this sequence.
    func removingNilValues<T>() -> [T] where Element == Optional<T> {
        self.compactMap(identity).map { $0! }
    }
}

