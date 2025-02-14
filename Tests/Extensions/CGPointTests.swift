#if canImport(CoreGraphics)

import XCTest
import CoreGraphics

@testable import FoundationPlus

final class CGPointTests: XCTestCase {

    func testPointDistanceCalculation() {
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
    
    func testRectDistanceCalculation() {
        let sourcePoint = CGPoint(x: 0, y: 0)
        let targetRect = CGRect(x: 3, y: 4, width: 100, height: 100)
        
        // Calculate distance
        let distanceTo = sourcePoint.distance(to: targetRect)
        
        XCTAssertEqual(distanceTo, 5.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }
    
    func testRectDistanceCalculation2() {
        let sourcePoint = CGPoint(x: 0, y: 0)
        let targetRect = CGRect(x: -5, y: -5, width: 2, height: 1)
        
        // Calculate distance
        let distanceTo = sourcePoint.distance(to: targetRect)
        
        XCTAssertEqual(distanceTo, 5.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }
}

#endif
