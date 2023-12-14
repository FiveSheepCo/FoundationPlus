import Foundation

public extension TimeInterval {
    
    /// Retrieves the day component of the time interval,
    /// representing the number of days within the current year.
    ///
    /// This property calculates the day component by dividing the time interval by the number of seconds in a day,
    /// then taking the remainder of division by 365. This represents the count of days not accounting for leap years.
    ///
    /// Example usage:
    /// ```swift
    /// let interval = TimeInterval(400000) // Represents a time interval
    /// let days = interval.dayComponent // Number of days within the year
    /// ```
    ///
    /// - Returns: The day component as a Double, disregarding leap years.
    var dayComponent: Double {
        days.truncatingRemainder(dividingBy: 365)
    }
    
    /// Retrieves the hour component of the time interval,
    /// representing the number of complete hours not forming a complete day.
    ///
    /// This property isolates the hour component by finding the remainder of the time interval's hour count when divided by 24,
    /// effectively extracting the hour part that doesn't compose a full day.
    ///
    /// Example usage:
    /// ```swift
    /// let interval = TimeInterval(10000) // Represents a time interval
    /// let hours = interval.hourComponent // Hours not composing a full day
    /// ```
    ///
    /// - Returns: The hour component as a Double.
    var hourComponent: Double {
        hours.truncatingRemainder(dividingBy: 24)
    }
    
    /// Retrieves the minute component of the time interval,
    /// representing the number of complete minutes not forming a complete hour.
    ///
    /// This property calculates the minute component by finding the remainder of the time interval's minute count when divided by 60,
    /// effectively extracting the minute part that doesn't compose a full hour.
    ///
    /// Example usage:
    /// ```swift
    /// let interval = TimeInterval(3600) // Represents 1 hour
    /// let minutes = interval.minuteComponent // Should be 0, as there are no extra minutes
    /// ```
    ///
    /// - Returns: The minute component as a Double.
    var minuteComponent: Double {
        minutes.truncatingRemainder(dividingBy: 60)
    }
    
    /// Retrieves the second component of the time interval,
    /// representing the number of seconds not forming a complete minute.
    ///
    /// This property isolates the second component by finding the remainder of the time interval's second count when divided by 60,
    /// effectively extracting the second part that doesn't compose a full minute.
    ///
    /// Example usage:
    /// ```swift
    /// let interval = TimeInterval(65) // Represents 65 seconds
    /// let seconds = interval.secondComponent // Should be 5, as there's 1 minute and 5 seconds
    /// ```
    ///
    /// - Returns: The second component as a Double.
    var secondComponent: Double {
        self.truncatingRemainder(dividingBy: 60)
    }
    
    /// Converts the time interval into `DateComponents`, encapsulating the day, hour, minute, and second components.
    ///
    /// This method constructs a `DateComponents` object from the time interval, setting only the `day`, `hour`, `minute`, and `second` fields.
    /// It's important to note that the returned `DateComponents` are in an unspecified calendar and timezone,
    /// and they represent only the respective components without considering a full calendar context.
    ///
    /// Example usage:
    /// ```swift
    /// let interval = TimeInterval(100000) // Represents a time interval
    /// let components = interval.dateComponents // `DateComponents` representing the interval
    /// ```
    ///
    /// - Returns: A `DateComponents` object containing day, hour, minute, and second components.
    var dateComponents: DateComponents {
        DateComponents(
            day: Int(dayComponent),
            hour: Int(hourComponent),
            minute: Int(minuteComponent),
            second: Int(secondComponent)
        )
    }
}
