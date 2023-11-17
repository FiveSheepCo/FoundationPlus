import Foundation

public extension Date {
    
    /// Calculates the time interval between this date and the current date and time.
    ///
    /// This property provides the duration from this date to now. It's the negation of
    /// `timeIntervalSinceNow`. If this date is in the past, the value is positive; if in the future,
    /// it's negative.
    ///
    /// Example:
    /// ```swift
    /// let pastDate = Date(timeIntervalSinceNow: -300) // 5 minutes in the past
    /// let interval = pastDate.timeIntervalUntilNow // About 300 seconds
    /// ```
    ///
    /// - Remark: Equivalent to `-timeIntervalSinceNow`.
    var timeIntervalUntilNow: TimeInterval {
        -timeIntervalSinceNow
    }
    
    /// Initializes a date value set to a specific time interval before the current date and time.
    ///
    /// This initializer creates a `Date` instance by subtracting the specified seconds from now.
    /// Useful for creating past dates relative to 'now'.
    ///
    /// - Parameter timeIntervalUntilNow: The seconds before now. Positive values indicate the past.
    ///
    /// Example:
    /// ```swift
    /// let dateFiveSecondsAgo = Date(timeIntervalUntilNow: 5) // Represents 5 seconds ago
    /// ```
    ///
    /// - Remark: Inverse of `init(timeIntervalSinceNow:)`.
    init(timeIntervalUntilNow: TimeInterval) {
        self.init(timeIntervalSinceNow: -timeIntervalUntilNow)
    }
}
