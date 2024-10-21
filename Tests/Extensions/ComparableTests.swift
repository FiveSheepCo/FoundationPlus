import XCTest

@testable import FoundationPlus

final class ComparableTests: XCTestCase {
    
    func testClamp() throws {
        XCTAssertEqual(Int(101).clamp(min: 0, max: 100), 100)
        XCTAssertEqual(Int(100).clamp(min: 0, max: 100), 100)
        XCTAssertEqual(Int(50).clamp(min: 0, max: 100), 50)
        XCTAssertEqual(Int(0).clamp(min: 0, max: 100), 0)
        XCTAssertEqual(Int(-1).clamp(min: 0, max: 100), 0)
    }
    
    func testClamp01Int() throws {
        XCTAssertEqual(Int(-1).clamp01(), 0)
        XCTAssertEqual(Int(0).clamp01(), 0)
        XCTAssertEqual(Int(1).clamp01(), 1)
        XCTAssertEqual(Int(2).clamp01(), 1)
    }
    
    func testClamp01Float() throws {
        XCTAssertEqual(Double(-1.0).clamp01(), 0.0)
        XCTAssertEqual(Double(0.0).clamp01(), 0.0)
        XCTAssertEqual(Double(1.0).clamp01(), 1.0)
        XCTAssertEqual(Double(2.0).clamp01(), 1.0)
    }
    
    func testLerp() throws {
        
        // Interpolation
        XCTAssertEqual(Double.lerp(a: 0, b: 1, t: 0), 0)
        XCTAssertEqual(Double.lerp(a: 0, b: 1, t: 0.5), 0.5)
        XCTAssertEqual(Double.lerp(a: 0, b: 1, t: 1), 1)
        
        // Extrapolation
        XCTAssertEqual(Double.lerp(a: 0, b: 1, t: -0.5), -0.5)
        XCTAssertEqual(Double.lerp(a: 0, b: 1, t: 1.5), 1.5)
    }
}
