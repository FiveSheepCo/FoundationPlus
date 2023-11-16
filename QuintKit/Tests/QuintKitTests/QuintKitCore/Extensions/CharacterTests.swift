import XCTest
@testable import QuintKitCore

final class Core__CharacterTests: XCTestCase {
    
    func testControlCharacters() throws {
        XCTAssertEqual(Character.space, " ")
        XCTAssertEqual(Character.newline, "\n")
        XCTAssertEqual(Character.tab, "\t")
    }
    
    func testToString() throws {
        XCTAssertEqual(Character.space.toString, String(" "))
    }
}
