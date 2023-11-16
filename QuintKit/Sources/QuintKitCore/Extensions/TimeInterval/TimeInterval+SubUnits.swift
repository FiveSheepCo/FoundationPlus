import Foundation

extension TimeInterval {
    
    /// Get the amount of days in the time interval.
    public var days: Double {
        self / 86400
    }
    
    /// Get the amount of hours in the time interval.
    public var hours: Double {
        self / 3600
    }
    
    /// Get the amount of minutes in the time interval.
    public var minutes: Double {
        self / 60
    }
    
    /// Get the amount of seconds in the time interval.
    public var seconds: Double {
        self
    }
}
