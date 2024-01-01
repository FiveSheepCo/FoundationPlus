import XCTest

@testable import FoundationPlus

final class Core__CalendarTests: XCTestCase {
    
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .init(identifier: "GMT+0100")!
        return calendar
    }
    
    func testFirstOfMonth() {
        let initialDate = Date(timeIntervalSince1970: 1703818401)   // Fri Dec 29 2023 03:53:21 GMT+0100 (CEST)
        let expectedDate = Date(timeIntervalSince1970: 1701385200)  // Fri Dec 01 2023 00:00:00 GMT+0100 (CEST)
        
        let actualDate = calendar.firstOfMonth(initialDate)
        
        XCTAssertNotNil(actualDate)
        XCTAssertEqual(actualDate?.timeIntervalSince1970, expectedDate.timeIntervalSince1970)
    }
    
    func testLastOfMonth() {
        let initialDate = Date(timeIntervalSince1970: 1703818401)   // Fri Dec 29 2023 03:53:21 GMT+0100 (CEST)
        let expectedDate = Date(timeIntervalSince1970: 1703977200)  // Sun Dec 31 2023 00:00:00 GMT+0100 (CEST)
        
        let actualDate = calendar.lastOfMonth(initialDate)
        
        XCTAssertNotNil(actualDate)
        XCTAssertEqual(actualDate?.timeIntervalSince1970, expectedDate.timeIntervalSince1970)
    }
    
    func testEndOfDay() {
        let initialDate = Date(timeIntervalSince1970: 1703818401)   // Fri Dec 29 2023 03:53:21 GMT+0100 (CEST)
        let expectedDate = Date(timeIntervalSince1970: 1703890799)  // Fri Dec 29 2023 23:59:59 GMT+0100 (CEST)
        
        let actualDate = calendar.endOfDay(initialDate)
        
        XCTAssertNotNil(actualDate)
        XCTAssertEqual(actualDate?.timeIntervalSince1970, expectedDate.timeIntervalSince1970)
    }
}
