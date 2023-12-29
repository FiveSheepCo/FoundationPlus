import XCTest

@testable import FoundationPlus

final class Core__DateTests: XCTestCase {
    
    // Honestly, I'm not sure how to implement the tests here.
    // TimeIntervalUntilNow always operates on the `now` date,
    // and it's not straight-forward to test in a reproducible way.
    // TODO: Revisit date tests
    
    func testUnixTimestamp() {
        let referenceDate = Date(timeIntervalSince1970: 1703818401.5)   // Fri Dec 29 2023 03:53:21:500 GMT+0100 (CEST)
        let expectedTimestamp = 1703818401
        
        XCTAssertEqual(referenceDate.unixTimestamp, expectedTimestamp)
    }
}
