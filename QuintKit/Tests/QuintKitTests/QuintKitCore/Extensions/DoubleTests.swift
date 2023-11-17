import XCTest
@testable import QuintKitCore

final class Core__DoubleTests: XCTestCase {
    
    func testToString() throws {
        XCTAssertEqual(10.0.toString, "10.0")
        XCTAssertEqual(10.5.toString, "10.5")
    }
}
