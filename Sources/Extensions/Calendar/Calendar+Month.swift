import Foundation

public extension Calendar {
    
    /// Calculates the first day of the month for a given `Date`.
    ///
    /// This function takes a `Date` object and returns the first day of its month.
    /// If the operation fails, `nil` is returned.
    ///
    /// The resulting date is normalized to the start of the day.
    ///
    /// - Parameter date: The `Date` object for which the first day of the month is calculated.
    /// - Returns: A `Date` representing the first day of the month, or `nil` if the calculation fails.
    func firstOfMonth(_ date: Date) -> Date? {
        let components = self.dateComponents(
            [.calendar, .timeZone, .era, .year, .quarter, .month],
            from: date
        )
        guard let date = self.date(from: components) else { return nil }
        return self.startOfDay(for: date)
    }
    
    /// Calculates the last day of the month for a given `Date`.
    ///
    /// This function takes a `Date` object and returns the last day of its month.
    /// If the operation fails, `nil` is returned. It calculates the first day of the month and then
    /// subtracts one day from the first day of the next month.
    ///
    /// The resulting date is normalized to the start of the day.
    ///
    /// - Parameter date: The `Date` object for which the last day of the month is calculated.
    /// - Returns: A `Date` representing the last day of the month, or `nil` if the calculation fails.
    ///
    /// - Note: If ``firstOfMonth(_:)`` fails, this will fail too.
    func lastOfMonth(_ date: Date) -> Date? {
        guard let date = self.firstOfMonth(date) else { return nil }
        guard let date = self.date(byAdding: DateComponents(month: 1), to: date) else { return nil }
        guard let date = self.date(byAdding: DateComponents(day: -1), to: date) else { return nil }
        return self.startOfDay(for: date)
    }
    
    /// Calculates the last moment of a given `Date`.
    func endOfDay(for date: Date) -> Date? {
        guard let nextDay = self.date(byAdding: .day, value: 1, to: date) else { return nil }
        return self.date(byAdding: .second, value: -1, to: self.startOfDay(for: nextDay))
    }
    
    /// Calculates the last moment of a given `Date`.
    @available(*, deprecated, message: "Use `endOfDay(for:)`, which is consistent with the `startOfDay(for:)`.")
    func endOfDay(_ date: Date) -> Date? {
        self.endOfDay(for: date)
    }
}
