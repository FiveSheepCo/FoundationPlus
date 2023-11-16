import XCTest
@testable import QuintKitCore

final class Core__BoolTests: XCTestCase {
    
    func testNegation() throws {
        XCTAssertTrue(false.negated)
        XCTAssertFalse(true.negated)
        XCTAssertFalse(false.negated.negated)
        XCTAssertTrue(false.negated.negated.negated)
    }
}
