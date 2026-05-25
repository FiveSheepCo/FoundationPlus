#if canImport(CoreGraphics)

import XCTest
import CoreGraphics

@testable import FoundationPlus

final class CGRectTests: XCTestCase {

    func testRectDistanceCalculationWhenOverlapping() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 50, y: 50, width: 100, height: 100)

        let distanceTo = rectA.distance(to: rectB)

        XCTAssertEqual(distanceTo, 0.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }

    func testRectDistanceCalculationWhenTouchingHorizontally() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 100, y: 25, width: 50, height: 50)

        let distanceTo = rectA.distance(to: rectB)

        XCTAssertEqual(distanceTo, 0.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }

    func testRectDistanceCalculationWhenTouchingVertically() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 25, y: 100, width: 50, height: 50)

        let distanceTo = rectA.distance(to: rectB)

        XCTAssertEqual(distanceTo, 0.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }

    func testRectDistanceCalculationWhenHorizontallySeparated() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 150, y: 25, width: 50, height: 50)

        let distanceTo = rectA.distance(to: rectB)

        XCTAssertEqual(distanceTo, 50.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }

    func testRectDistanceCalculationWhenVerticallySeparated() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 25, y: 150, width: 50, height: 50)

        let distanceTo = rectA.distance(to: rectB)

        XCTAssertEqual(distanceTo, 50.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }

    func testRectDistanceCalculationWhenDiagonallySeparated() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 130, y: 140, width: 50, height: 50)

        let distanceTo = rectA.distance(to: rectB)

        // Horizontal gap: 30
        // Vertical gap: 40
        // Distance: sqrt(30² + 40²) = 50
        XCTAssertEqual(distanceTo, 50.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }

    func testRectDistanceCalculationWhenContained() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 25, y: 25, width: 50, height: 50)

        let distanceTo = rectA.distance(to: rectB)

        XCTAssertEqual(distanceTo, 0.0, accuracy: 0.0001, "Distance to calculation is incorrect.")
    }

    func testRectDistanceCalculationIsSymmetric() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 130, y: 140, width: 50, height: 50)

        let distanceAToB = rectA.distance(to: rectB)
        let distanceBToA = rectB.distance(to: rectA)

        XCTAssertEqual(distanceAToB, distanceBToA, accuracy: 0.0001, "Distance to calculation should be symmetric.")
    }

    func testRectSquaredDistanceCalculation() {
        let rectA = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rectB = CGRect(x: 130, y: 140, width: 50, height: 50)

        let squaredDistanceTo = rectA.distanceSquared(to: rectB)

        // Horizontal gap: 30
        // Vertical gap: 40
        // Squared distance: 30² + 40² = 2500
        XCTAssertEqual(squaredDistanceTo, 2500.0, accuracy: 0.0001, "Squared distance to calculation is incorrect.")
    }
}

#endif
