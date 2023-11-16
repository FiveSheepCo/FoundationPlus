import XCTest
@testable import QuintKitCore

final class Core__StringTests: XCTestCase {
    
    func testRemovingObjectReplacementMarkers() throws {
        let subject = "Hello world!\u{fffc}"
        let expected = "Hello world!"
        XCTAssertEqual(subject.removingObjectReplacementMarkers(), expected)
    }
}
