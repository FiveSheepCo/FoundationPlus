#if canImport(CoreGraphics)

import Foundation
import CoreGraphics

public extension CGPoint {
    
    /// Calculates the distance from this point to another specified point.
    ///
    /// This method computes the Euclidean distance between the current point and another point.
    /// The distance is calculated using the Pythagorean theorem, ensuring accuracy in a 2D coordinate space.
    ///
    /// - Parameter to: The `CGPoint` to which the distance is measured.
    /// - Returns: The distance as a `CGFloat`.
    func distance(to point: CGPoint) -> CGFloat {
        let dx = self.x - point.x
        let dy = self.y - point.y
        return sqrt(dx * dx + dy * dy)
    }
    
    /// Calculates the distance from this point to the closest edge of the specified `CGRect`.
    ///
    /// This method computes the Euclidean distance between the current point and the closest edge of a `CGRect`.
    /// The distance is calculated using the Pythagorean theorem, ensuring accuracy in a 2D coordinate space.
    ///
    /// - Parameter to: The `CGRect` to which the distance is measured.
    /// - Returns: The distance as a `CGFloat`.
    func distance(to rect: CGRect) -> CGFloat {
        let dx = max(rect.minX - self.x, 0, self.x - rect.maxX)
        let dy = max(rect.minY - self.y, 0, self.y - rect.maxY)
        return sqrt(dx * dx + dy * dy)
    }
}

#endif
