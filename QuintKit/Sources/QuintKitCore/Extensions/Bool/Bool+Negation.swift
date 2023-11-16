import Foundation

extension Bool {
    
    /// A Boolean value that is the logical negation of the original value.
    ///
    /// This computed property returns `true` if the original value is `false`, and `false`
    /// if the original value is `true`. It's useful for improving readability in conditions
    /// and for performing logical negations without altering the original Boolean value.
    ///
    /// Example usage:
    /// ```swift
    /// let truth = true
    /// let falsehood = truth.negated
    /// // falsehood is false
    /// ```
    ///
    /// - Returns: The negated (inverted) value of the Boolean.
    public var negated: Self {
        !self
    }
}
