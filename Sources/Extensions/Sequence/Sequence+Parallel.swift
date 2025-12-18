import Foundation

public extension Sequence where Element: Sendable {

    /// Performs a map operation on the sequence's elements concurrently.
    ///
    /// The transformed elements are collected
    /// and returned as an array, preserving their original order. This method can be useful for scenarios
    /// where the transformation is resource-intensive or involves asynchronous I/O operations.
    ///
    /// - Parameters:
    ///   - preservingOrder: Whether the original order of elements should be preserved.
    ///   - transform: An asynchronous closure that takes an element of the sequence as its argument and
    ///     returns a transformed value of type `T`.
    /// - Returns: An array of transformed values `T`.
    /// - Throws: Rethrows any errors encountered during the filtering process. Due to implementation details,
    ///   `parallelMap` can't use the `rethrows` keyword. In practice, it only throws if the `transform` function throws.
    func parallelMap<T: Sendable>(
        preservingOrder: Bool = true,
        _ transform: @Sendable @escaping (Element) async throws -> T
    ) async rethrows -> [T] {
        try await withThrowingTaskGroup(of: (Int, T).self, returning: [T].self) { group in
            var results: [(Int, T)] = []
            results.reserveCapacity(self.underestimatedCount)

            var index = 0
            for element in self {
                let indexCopy = index
                group.addTask {
                    (indexCopy, try await transform(element))
                }
                index += 1
            }

            for try await (index, element) in group {
                results.append((index, element))
            }

            return if preservingOrder {
                results
                    .sorted(by: \.0, ascending: true)
                    .map(\.1)
            } else {
                results.map(\.1)
            }
        }
    }

    /// Performs a filter operation on the sequence's elements concurrently.
    ///
    /// Elements that satisfy the closure (return `true`)
    /// are included in the result array, preserving their original order. This method is beneficial when the predicate
    /// evaluation is resource-intensive or involves asynchronous I/O operations.
    ///
    /// - Parameters:
    ///   - preservingOrder: Whether the original order of elements should be preserved.
    ///   - isIncluded: An asynchronous closure that takes an element of the sequence as its argument and
    ///     returns a Boolean value indicating whether the element should be included in the returned array.
    /// - Returns: An array of elements that satisfy the predicate `isIncluded`.
    /// - Throws: Rethrows any errors encountered during the filtering process. Due to implementation details,
    ///   `parallelFilter` can't use the `rethrows` keyword. In practice, it only throws if the `isIncluded` function throws.
    func parallelFilter(
        preservingOrder: Bool = true,
        _ isIncluded: @Sendable @escaping (Element) async throws -> Bool
    ) async throws -> [Element] {
        try await withThrowingTaskGroup(of: Optional<(Int, Element)>.self, returning: [Element].self) { group in
            var results = [(Int, Element)]()

            var index = 0
            for element in self {
                let indexCopy = index
                group.addTask {
                    try await isIncluded(element) ? (indexCopy, element) : nil
                }
                index += 1
            }

            for try await result in group {
                if let (index, element) = result {
                    results.append((index, element))
                }
            }

            return if preservingOrder {
                results
                    .sorted(by: \.0, ascending: true)
                    .map(\.1)
            } else {
                results.map(\.1)
            }
        }
    }
}
