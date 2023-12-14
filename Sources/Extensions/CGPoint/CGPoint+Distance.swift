#if canImport(CoreGraphics)

import Foundation
import CoreGraphics

public extension CGPoint {
    
    /// Calculates the distance from this point to another specified point.
    ///
    /// This method computes the Euclidean distance between the current point and another point.
    /// The distance is calculated using the Pythagorean theorem, ensuring accuracy in a 2D coordinate space.
    ///
    /// - Parameter to: The CGPoint to which the distance is measured.
    /// - Returns: The distance as a CGFloat.
    func distance(to point: CGPoint) -> CGFloat {
        let xDist = self.x - point.x
        let yDist = self.y - point.y
        return CGFloat(sqrt(pow(xDist, 2) + pow(yDist, 2)))
    }
}

#endif
