import XCTest

@testable import FoundationPlus

final class Core__SequenceTests: XCTestCase {
    
    func testRemovingNilValues() {
        XCTAssertEqual([1, nil, 2].removingNilValues(), [1, 2])
    }
}
