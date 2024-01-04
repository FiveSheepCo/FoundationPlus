import XCTest

@testable import FoundationPlus

final class DateFormatterTests: XCTestCase {
    
    func testConvenienceInit() throws {
        XCTAssertEqual(DateFormatter(dateStyle: .full).dateStyle, .full)
        XCTAssertEqual(DateFormatter(dateStyle: .short).dateStyle, .short)
        XCTAssertEqual(DateFormatter(timeStyle: .full).timeStyle, .full)
        XCTAssertEqual(DateFormatter(timeStyle: .short).timeStyle, .short)
        
        ({
            let formatter = DateFormatter(dateStyle: .full, timeStyle: .full)
            XCTAssertEqual(formatter.dateStyle, .full)
            XCTAssertEqual(formatter.timeStyle, .full)
        })()
        
        ({
            let formatter = DateFormatter(dateStyle: .short, timeStyle: .short)
            XCTAssertEqual(formatter.dateStyle, .short)
            XCTAssertEqual(formatter.timeStyle, .short)
        })()
        
        ({
            let formatter = DateFormatter(dateStyle: .medium, timeStyle: .long)
            XCTAssertEqual(formatter.dateStyle, .medium)
            XCTAssertEqual(formatter.timeStyle, .long)
        })()
    }
}
