#if canImport(CoreGraphics)

import Foundation
import CoreGraphics

public extension CGVector {
    
    /// Calculate the magnitude (or length) of the vector.
    ///
    /// - Returns: The magnitude of the vector.
    @inline(__always)
    var magnitude: CGFloat {
        sqrt(magnitudeSquared)
    }
    
    /// Calculate the squared magnitude (or length) of the vector.
    ///
    /// - Returns: The squared magnitude of the vector.
    @inline(__always)
    var magnitudeSquared: CGFloat {
        dx * dx + dy * dy
    }
    
    /// Return a normalized version of the vector.
    /// The normalized vector points in the same direction but has a magnitude of 1.
    ///
    /// - Returns: A normalized vector.
    var normalized: CGVector {
        let length = self.magnitude
        return CGVector(dx: dx / length, dy: dy / length)
    }
    
    /// Normalize the vector.
    /// The normalized vector points in the same direction but has a magnitude of 1.
    mutating func normalize() {
        self = self.normalized
    }
}

#endif
