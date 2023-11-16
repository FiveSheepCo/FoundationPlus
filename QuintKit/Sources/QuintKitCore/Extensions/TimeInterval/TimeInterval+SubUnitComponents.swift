import Foundation

extension TimeInterval {
    
    /// Get the day component of the time interval.
    public var dayComponent: Double {
        days.truncatingRemainder(dividingBy: 365)
    }
    
    /// Get the hour component of the time interval.
    public var hourComponent: Double {
        hours.truncatingRemainder(dividingBy: 24)
    }
    
    /// Get the minute component of the time interval.
    public var minuteComponent: Double {
        minutes.truncatingRemainder(dividingBy: 60)
    }
    
    /// Get the second component of the time interval.
    public var secondComponent: Double {
        self.truncatingRemainder(dividingBy: 60)
    }
    
    /// Get the `DateComponents` of this time interval.
    ///
    /// The returned value is in an unspecified calendar and timezone.
    /// Only the `day`, `hour`, `minute` and `second` components are set.
    public var dateComponents: DateComponents {
        DateComponents(
            day: Int(dayComponent),
            hour: Int(hourComponent),
            minute: Int(minuteComponent),
            second: Int(secondComponent)
        )
    }
}
