import Foundation

/// An actor for managing parallel tasks on sequences.
///
/// Handles the concurrent execution of tasks, ensuring that the number of tasks running in parallel
/// does not exceed a specified limit. It also maintains the order of results and handles errors.
actor ParallelSequenceActor<T> {
    
    /// The max number of active tasks managed by the actor at any given moment.
    private let concurrencyLimit: Int
    
    private var error: Error?
    private var tasks = [UUID : Task<(), Error>]()
    private var values = [(order: Int, value: T)]()
    private var index = 0
    
    /// Initializes a new actor with a specified limit for concurrent tasks.
    ///
    /// - Parameter concurrencyLimit: The maximum number of tasks that can be run in parallel.
    ///   This value is clamped to a minimum of 1.
    init(concurrencyLimit: Int) {
        self.concurrencyLimit = max(1, concurrencyLimit)
    }
    
    /// Waits for all scheduled tasks to complete and returns the results.
    ///
    /// This method continuously yields control until all tasks have been completed. If any task encounters
    /// an error, it throws that error. Otherwise, it returns an array of the results, preserving the order
    /// in which tasks were scheduled.
    ///
    /// - Returns: An array of results produced by the tasks.
    /// - Throws: Rethrows any error encountered by a task.
    func waitForFinish() async throws -> [T] {
        while !tasks.isEmpty {
            await Task.yield()
        }
        if let error { throw error }
        return values.sorted { a, b in a.order < b.order }.map(\.1)
    }
    
    /// Schedules a new task for execution, respecting the concurrency limit.
    ///
    /// Ensures that the number of concurrent tasks does not exceed the specified limit.
    /// If an error has been encountered in any previously scheduled task, it immediately throws that error.
    ///
    /// - Parameter block: A closure representing the task to be executed.
    /// - Throws: Rethrows any error encountered by previously scheduled tasks.
    func scheduleTask(_ block: @escaping () async throws -> ParallelResult) async throws {
        
        // Wait for a free concurrency slot to become available
        while tasks.count >= concurrencyLimit {
            await Task.yield()
        }
        
        // Rethrow any previously encountered, unhandled errors
        if let error { throw error }
        
        // Increment the index at the end of the block
        defer { self.index += 1 }
        
        // Prepare task-related metadata
        let index = self.index
        let uuid = UUID()
        
        // Spawn the task
        tasks[uuid] = Task<(), Error> {
            
            // Free the concurrency slot at the end of the block
            defer { tasks.removeValue(forKey: uuid) }
            
            do {
                if case .return(let value) = try await block() {
                    values.append((index, value))
                }
            } catch (let error) {
                self.error = error
            }
        }
    }
    
    /// Represents the result of a parallel computation task.
    enum ParallelResult {
        
        /// The task has completed and returns a value of type `T`.
        case `return`(T)
        
        /// The task has completed but does not provide a result.
        case skip
    }
}
