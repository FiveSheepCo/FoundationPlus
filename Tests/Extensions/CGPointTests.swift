#if canImport(CoreGraphics)

import XCTest
import CoreGraphics

@testable import FoundationPlus

final class Core__CGPointTests: XCTestCase {

    func testDistanceCalculation() {
        // Define two points
        let pointA = CGPoint(x: 0, y: 0)
        let pointB = CGPoint(x: 3, y: 4) // 3-4-5 right triangle for easy validation

        // Calculate distance
        let distanceTo = pointA.distance(to: pointB)

        // Expected distance is 5.0 (Pythagorean theorem)
        let expectedDistance: CGFloat = 5.0

        // Assert that calculated distances are equal to expected distance
        XCTAssertEqual(distanceTo, expectedDistance, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }
}

#endif
