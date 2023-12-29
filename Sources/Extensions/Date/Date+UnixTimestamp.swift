import Foundation

public extension Date {
    
    /// The Unix epoch timestamp in seconds.
    ///
    /// This property’s value is negative if the date object is earlier than 00:00:00 UTC on 1 January 1970.
    var unixTimestamp: Int {
        Int(floor(self.timeIntervalSince1970))
    }
}
