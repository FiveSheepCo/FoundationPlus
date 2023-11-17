import Foundation

public extension Date {
    
    /// Returns a new date instance representing only the date component, at the start of the day.
    ///
    /// This property strips time info (hours, minutes, seconds), leaving year, month, day, adjusted
    /// to the current timezone. Useful for day-by-day date comparisons.
    ///
    /// Example:
    /// ```swift
    /// let now = Date()
    /// let justTheDate = now.dateOnly // Today's date, time at 00:00:00
    /// ```
    ///
    /// - Returns: A `Date` object representing the start of the day for the date's year, month, and day.
    var dateOnly: Date {
        get {
            let calendar = Calendar.current
            var components = calendar.dateComponents(
                [.year, .month, .day, .calendar, .timeZone], from: self
            )
            components.timeZone = TimeZone.autoupdatingCurrent
            return calendar.date(from: components)!
        }
    }
}
