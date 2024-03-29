import XCTest

@testable import FoundationPlus

final class CharacterTests: XCTestCase {
    
    func testControlCharacters() throws {
        XCTAssertEqual(Character.space, " ")
        XCTAssertEqual(Character.newline, "\n")
        XCTAssertEqual(Character.tab, "\t")
    }
    
    func testToString() throws {
        XCTAssertEqual(Character.space.toString, String(" "))
    }
    
    func lowercased() throws {
        XCTAssertEqual(Character("a").lowercased, "a")
        XCTAssertEqual(Character("A").lowercased, "a")
    }
    
    func uppercased() throws {
        XCTAssertEqual(Character("a").lowercased, "A")
        XCTAssertEqual(Character("A").lowercased, "A")
    }
}
