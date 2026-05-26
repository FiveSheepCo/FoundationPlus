import Foundation

public extension String {
    
    /// Returns a localized version of the string.
    @inlinable
    func localized(comment: String = .empty) -> String {
        NSLocalizedString(self, comment: comment)
    }
    
    /// Returns a localized version of the string.
    @available(*, deprecated, message: "Use `localized(comment:)` instead.")
    @inlinable
    func localized(with comment: String = .empty) -> String {
        self.localized(comment: comment)
    }
}
