import XCTest

@testable import FoundationPlus

final class StringTests: XCTestCase {
    
    func testRemovingObjectReplacementMarkers() throws {
        let subject = "Hello world!\u{fffc}"
        let expected = "Hello world!"
        XCTAssertEqual(subject.removingObjectReplacementMarkers(), expected)
    }
    
    func testLines() {
        let subject = "Hello\nWorld\n\nTest"
        let expected = ["Hello", "World", "", "Test"]
        XCTAssertEqual(subject.lines, expected)
    }
    
    func testUrlEncoding() {
        let subject = "Hello World!"
        let expected = "Hello%20World%21"
        XCTAssertEqual(subject.urlEncoded, expected)
    }
    
    func testUrlDecoding() {
        let subject = "Hello%20World%21"
        let expected = "Hello World!"
        XCTAssertEqual(subject.urlDecoded, expected)
    }
    
    func testRemovingOccurrences() {
        let subject = "FooFooHelloFoo FooWorldFooFoo"
        let expected = "Hello World"
        XCTAssertEqual(subject.removingOccurrences(of: "Foo"), expected)
    }
    
    func testRemovingOccurrencesOfPrefix() {
        let subject = "FooFooHello World FooFoo"
        let expected = "Hello World FooFoo"
        XCTAssertEqual(subject.removingOccurrences(ofPrefix: "Foo"), expected)
    }
    
    func testRemovingOccurrencesOfSuffix() {
        let subject = "FooFoo Hello WorldFooFoo"
        let expected = "FooFoo Hello World"
        XCTAssertEqual(subject.removingOccurrences(ofSuffix: "Foo"), expected)
    }
    
    func testSubstringWithRange() {
        let subject = "TestToastWords"
        
        XCTAssertEqual(subject[...3], "Test")
        XCTAssertEqual(subject[..<4], "Test")
        XCTAssertEqual(subject[4..<9], "Toast")
        XCTAssertEqual(subject[4...8], "Toast")
        XCTAssertEqual(subject[9...], "Words")
    }
    
    func testIdentifiableId() {
        let subject = "Hello World"
        
        XCTAssertEqual(subject.id, subject)
    }
}
