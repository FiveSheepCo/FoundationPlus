import XCTest

@testable import FoundationPlus

final class DictionaryTests: XCTestCase {
    
    func testPlusOperator() {
        let a = ["a": 1, "b": 2]
        let b = ["c": 3, "d": 4]
        let c = ["c": 3, "b": 4]
        
        let d = a + b
        let e = a + c
        
        XCTAssertEqual(d, ["a": 1, "b": 2, "c": 3, "d": 4])
        XCTAssertEqual(e, ["a": 1, "b": 4, "c": 3])
    }
    
    func testKeys() {
        let dict = ["a": 1, "b": 2, "c": 1, "d": 2, "e": 3]
        
        XCTAssertEqual(dict.keys(for: 0), [])
        XCTAssertEqual(dict.keys(for: 1).sorted(), ["a", "c"])
        XCTAssertEqual(dict.keys(for: 2).sorted(), ["b", "d"])
        XCTAssertEqual(dict.keys(for: 3), ["e"])
    }
}
