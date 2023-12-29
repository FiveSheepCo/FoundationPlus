import XCTest

@testable import FoundationPlus

final class Core__CalendarTests: XCTestCase {
    
    func testFirstOfMonth() {
        let initialDate = Date(timeIntervalSince1970: 1703818401)   // Fri Dec 29 2023 03:53:21 GMT+0100 (CEST)
        let expectedDate = Date(timeIntervalSince1970: 1701385200)  // Fri Dec 01 2023 00:00:00 GMT+0100 (CEST)
        
        let actualDate = Calendar.current.firstOfMonth(initialDate)
        
        XCTAssertNotNil(actualDate)
        XCTAssertEqual(actualDate?.timeIntervalSince1970, expectedDate.timeIntervalSince1970)
    }
    
    func testLastOfMonth() {
        let initialDate = Date(timeIntervalSince1970: 1703818401)   // Fri Dec 29 2023 03:53:21 GMT+0100 (CEST)
        let expectedDate = Date(timeIntervalSince1970: 1703977200)  // Sun Dec 31 2023 00:00:00 GMT+0100 (CEST)
        
        let actualDate = Calendar.current.lastOfMonth(initialDate)
        
        XCTAssertNotNil(actualDate)
        XCTAssertEqual(actualDate?.timeIntervalSince1970, expectedDate.timeIntervalSince1970)
    }
}
