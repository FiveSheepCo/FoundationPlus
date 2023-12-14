import Foundation

public extension DateFormatter {
    
    /// Creates a `DateFormatter` with specified date and time styles.
    ///
    /// This initializer allows you to create a `DateFormatter` and set both the date and time
    /// formatting styles in one step. It is convenient when you need to format both date and time
    /// components of a date.
    ///
    /// - Parameters:
    ///   - dateStyle: The style to use for formatting the date. See `DateFormatter.Style` for options.
    ///   - timeStyle: The style to use for formatting the time. See `DateFormatter.Style` for options.
    convenience init(dateStyle: Style, timeStyle: Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
    
    /// Creates a `DateFormatter` with a specified date style.
    ///
    /// Use this initializer to create a `DateFormatter` that formats only the date component, ignoring
    /// time. This is useful when the time is not relevant or not available.
    ///
    /// - Parameter dateStyle: The style to use for the date. See `DateFormatter.Style` for options.
    convenience init(dateStyle: Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = .none
    }
    
    /// Creates a `DateFormatter` with a specified time style.
    ///
    /// Use this initializer to create a `DateFormatter` that formats only the time component, ignoring
    /// the date. This is suitable when the focus is solely on time values.
    ///
    /// - Parameter timeStyle: The style to use for the time. See `DateFormatter.Style` for options.
    convenience init(timeStyle: Style) {
        self.init()
        self.dateStyle = .none
        self.timeStyle = timeStyle
    }
}
