import Foundation

public extension TimeInterval {
    
    /// Retrieves the total number of days in the time interval.
    /// This property divides the interval's total seconds by 86,400 (seconds in a day) to calculate
    /// the total days, including fractional parts.
    ///
    /// Example:
    /// ```swift
    /// let interval = TimeInterval(172800) // Represents 2 days
    /// let totalDays = interval.days // 2.0
    /// ```
    ///
    /// - Returns: Total number of days as a Double.
    var days: Double {
        self / 86400
    }
    
    /// Retrieves the total number of hours in the time interval.
    /// This property divides the interval's total seconds by 3,600 (seconds in an hour) to calculate
    /// the total hours, including fractional parts.
    ///
    /// Example:
    /// ```swift
    /// let interval = TimeInterval(10800) // Represents 3 hours
    /// let totalHours = interval.hours // 3.0
    /// ```
    ///
    /// - Returns: Total number of hours as a Double.
    var hours: Double {
        self / 3600
    }
    
    /// Retrieves the total number of minutes in the time interval.
    /// This property divides the interval's total seconds by 60 to calculate the total minutes,
    /// including fractional parts.
    ///
    /// Example:
    /// ```swift
    /// let interval = TimeInterval(600) // Represents 10 minutes
    /// let totalMinutes = interval.minutes // 10.0
    /// ```
    ///
    /// - Returns: Total number of minutes as a Double.
    var minutes: Double {
        self / 60
    }
    
    /// Retrieves the total number of seconds in the time interval.
    /// This property directly represents the interval's value in seconds, useful for clarity when
    /// manipulating or displaying time intervals.
    ///
    /// Example:
    /// ```swift
    /// let interval = TimeInterval(120) // Represents 120 seconds
    /// let totalSeconds = interval.seconds // 120.0
    /// ```
    ///
    /// - Returns: Total number of seconds as a Double.
    var seconds: Double {
        self
    }
}
