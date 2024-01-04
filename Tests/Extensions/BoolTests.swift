import XCTest

@testable import FoundationPlus

final class BoolTests: XCTestCase {
    
    func testNegation() throws {
        XCTAssertTrue(false.negated)
        XCTAssertFalse(true.negated)
        XCTAssertFalse(false.negated.negated)
        XCTAssertTrue(false.negated.negated.negated)
    }
}
