import Foundation

extension Comparable {
    
    /// Clamps the receiver between `min` and `max`.
    ///
    /// Example usage:
    /// ```
    /// 100.clamp(min: 0, max: 50) // 50
    /// ```
    @inline(__always)
    func clamp(min: Self, max: Self) -> Self {
        Swift.max(Swift.min(self, max), min)
    }
}

extension Comparable where Self: ExpressibleByIntegerLiteral {
    
    /// Clamps the receiver between `0` and `1`.
    @inline(__always)
    func clamp01() -> Self {
        self.clamp(min: 0, max: 1)
    }
}
