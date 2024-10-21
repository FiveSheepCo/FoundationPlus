#if canImport(CoreGraphics)

import XCTest
import CoreGraphics

@testable import FoundationPlus

final class CGVectorTests: XCTestCase {
    
    func testMagnitude() {
        XCTAssertEqual(CGVector(dx: 10, dy: 10).magnitudeSquared, 200)
        XCTAssertEqual(CGVector(dx: 3, dy: 4).magnitudeSquared, 25)
        
        XCTAssertEqual(CGVector(dx: 10, dy: 10).magnitude, 14.142135, accuracy: 0.0001)
        XCTAssertEqual(CGVector(dx: 3, dy: 4).magnitude, 5, accuracy: 0.0001)
    }
    
    func testNormalized() {
        XCTAssertEqual(CGVector(dx: 10, dy: 10).normalized.dx, 0.7071, accuracy: 0.0001)
        XCTAssertEqual(CGVector(dx: 3, dy: 4).normalized, CGVector(dx: 0.6, dy: 0.8))
    }
    
    func testNormalize() {
        var vec = CGVector(dx: 3, dy: 4)
        vec.normalize()
        XCTAssertEqual(vec.dx, 0.6)
        XCTAssertEqual(vec.dy, 0.8)
    }
}

#endif
