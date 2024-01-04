import Foundation

public extension Sequence {
    
    /// Performs a map operation on the sequence's elements concurrently.
    ///
    /// The degree of concurrency is controlled by `maxConcurrency`. The transformed elements are collected
    /// and returned as an array, preserving their original order. This method can be useful for scenarios
    /// where the transformation is resource-intensive or involves asynchronous I/O operations.
    ///
    /// - Parameters:
    ///   - maxConcurrency: The maximum number of concurrent tasks. Defaults to the number of available CPU cores.
    ///   - transform: An asynchronous closure that takes an element of the sequence as its argument and
    ///     returns a transformed value of type `T`.
    /// - Returns: An array of transformed values `T`.
    /// - Throws: Rethrows any errors encountered during the filtering process. Due to implementation details,
    ///   `parallelMap` can't use the `rethrows` keyword. In practice, it only throws if the `transform` function throws.
    func parallelMap<T>(
        maxConcurrency: Int = ProcessInfo().activeProcessorCount,
        _ transform: @escaping (Element) async throws -> T
    ) async throws -> [T] {
        let actor = ParallelSequenceActor<T>(concurrencyLimit: maxConcurrency)

        for element in self {
            try await actor.scheduleTask {
                .return(try await transform(element))
            }
        }
        
        return try await actor.waitForFinish()
    }
    
    /// Performs a filter operation on the sequence's elements concurrently.
    ///
    /// The degree of concurrency is controlled by `maxConcurrency` Elements that satisfy the closure (return `true`)
    /// are included in the result array, preserving their original order. This method is beneficial when the predicate
    /// evaluation is resource-intensive or involves asynchronous I/O operations.
    ///
    /// - Parameters:
    ///   - maxConcurrency: The maximum number of concurrent tasks. Defaults to the number of available CPU cores.
    ///   - isIncluded: An asynchronous closure that takes an element of the sequence as its argument and
    ///     returns a Boolean value indicating whether the element should be included in the returned array.
    /// - Returns: An array of elements that satisfy the predicate `isIncluded`.
    /// - Throws: Rethrows any errors encountered during the filtering process. Due to implementation details,
    ///   `parallelFilter` can't use the `rethrows` keyword. In practice, it only throws if the `isIncluded` function throws.
    func parallelFilter(
        maxConcurrency: Int = ProcessInfo().activeProcessorCount,
        _ isIncluded: @escaping (Element) async throws -> Bool
    ) async throws -> [Element] {
        let actor = ParallelSequenceActor<Element>(concurrencyLimit: maxConcurrency)

        for element in self {
            try await actor.scheduleTask {
                if try await isIncluded(element) {
                    .return(element)
                } else {
                    .skip
                }
            }
        }
        
        return try await actor.waitForFinish()
    }
}
