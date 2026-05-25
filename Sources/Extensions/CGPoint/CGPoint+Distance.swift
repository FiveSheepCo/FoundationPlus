#if canImport(CoreGraphics)

import Foundation
import CoreGraphics

public extension CGPoint {
    
    /// Calculates the distance from this point to another specified point.
    ///
    /// This method computes the Euclidean distance between the current point and another point.
    /// The distance is calculated using the Pythagorean theorem, ensuring accuracy in a 2D coordinate space.
    ///
    /// - Parameter point: The `CGPoint` to which the distance is measured.
    /// - Returns: The distance as a `CGFloat`.
    @inlinable
    func distance(to point: CGPoint) -> CGFloat {
        sqrt(distanceSquared(to: point))
    }
    
    /// Calculates the distance from this point to the closest edge of the specified `CGRect`.
    ///
    /// This method computes the Euclidean distance between the current point and the closest edge of a `CGRect`.
    /// The distance is calculated using the Pythagorean theorem, ensuring accuracy in a 2D coordinate space.
    ///
    /// - Parameter rect: The `CGRect` to which the distance is measured.
    /// - Returns: The distance as a `CGFloat`.
    @inlinable
    func distance(to rect: CGRect) -> CGFloat {
        sqrt(distanceSquared(to: rect))
    }
    
    /// Calculates the squared distance from this point to another specified point.
    ///
    /// This can be useful when the actual Euclidean distance isn't necessary, for example
    /// when comparing distances or sorting by distance.
    ///
    /// - Parameter point: The `CGPoint` to which the distance is measured.
    /// - Returns: The distance as a `CGFloat`.
    @inlinable
    func distanceSquared(to point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        return dx * dx + dy * dy
    }
    
    /// Calculates the squared distance from this point to the closest edge of the specified `CGRect`.
    ///
    /// This can be useful when the actual Euclidean distance isn't necessary, for example
    /// when comparing distances or sorting by distance.
    ///
    /// - Parameter rect: The `CGRect` to which the distance is measured.
    /// - Returns: The distance as a `CGFloat`.
    @inlinable
    func distanceSquared(to rect: CGRect) -> CGFloat {
        let closestX = min(max(self.x, rect.minX), rect.maxX)
        let closestY = min(max(self.y, rect.minY), rect.maxY)
        let dx = self.x - closestX
        let dy = self.y - closestY
        return dx * dx + dy * dy
    }
}

#endif
