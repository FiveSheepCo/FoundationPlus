import Foundation

public extension Calendar {
    
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
