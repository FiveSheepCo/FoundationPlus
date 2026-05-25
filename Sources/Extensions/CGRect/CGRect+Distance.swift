#if canImport(CoreGraphics)

import Foundation
import CoreGraphics

public extension CGRect {
    
    /// Returns the shortest distance between this rectangle and another rectangle.
    ///
    /// The distance is `0` when the rectangles overlap or touch.
    ///
    /// - Parameter other: The rectangle to measure the distance to.
    /// - Returns: The shortest distance between the two rectangles.
    @inlinable
    func distance(to other: CGRect) -> CGFloat {
        sqrt(distanceSquared(to: other))
    }

    /// Returns the squared shortest distance between this rectangle and another rectangle.
    ///
    /// The result is `0` when the rectangles overlap or touch. Use this method when comparing distances and the exact
    /// distance is not needed, as it avoids the square-root calculation performed by `distance(to:)`.
    ///
    /// - Parameter other: The rectangle to measure the squared distance to.
    /// - Returns: The squared shortest distance between the two rectangles.
    @inlinable
    func distanceSquared(to other: CGRect) -> CGFloat {
        let dx: CGFloat

        if self.maxX < other.minX {
            dx = other.minX - self.maxX
        } else if other.maxX < self.minX {
            dx = self.minX - other.maxX
        } else {
            dx = 0
        }

        let dy: CGFloat

        if self.maxY < other.minY {
            dy = other.minY - self.maxY
        } else if other.maxY < self.minY {
            dy = self.minY - other.maxY
        } else {
            dy = 0
        }

        return dx * dx + dy * dy
    }
}

#endif
