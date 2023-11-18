import XCTest

@testable import QuintKitCore

final class Core__TimeIntervalTests: XCTestCase {
    
    func testSubUnits() throws {
        let subject: TimeInterval = 432000 // 5 days
        let expectedDays: TimeInterval = 5
        let expectedHours = expectedDays * 24
        let expectedMinutes = expectedHours * 60
        let expectedSeconds = expectedMinutes * 60
        XCTAssertEqual(subject.days, expectedDays)
        XCTAssertEqual(subject.hours, expectedHours)
        XCTAssertEqual(subject.minutes, expectedMinutes)
        XCTAssertEqual(subject.seconds, expectedSeconds)
    }
    
    func testSubUnitComponents() throws {
        XCTAssertEqual(TimeInterval(10).secondComponent, 10)
        XCTAssertEqual(TimeInterval(60).secondComponent, 0)
        XCTAssertEqual(TimeInterval(61).secondComponent, 1)
        XCTAssertEqual(TimeInterval(30).minuteComponent, 0.5)
        XCTAssertEqual(TimeInterval(60).minuteComponent, 1)
        XCTAssertEqual(TimeInterval(120).minuteComponent, 2)
        XCTAssertEqual(TimeInterval(1800).hourComponent, 0.5)
        XCTAssertEqual(TimeInterval(3600).hourComponent, 1)
        XCTAssertEqual(TimeInterval(4500).hourComponent, 1.25)
        XCTAssertEqual(TimeInterval(43200).dayComponent, 0.5)
        XCTAssertEqual(TimeInterval(86400).dayComponent, 1)
        XCTAssertEqual(TimeInterval(86459).secondComponent, 59)
        XCTAssertEqual(TimeInterval(86430).minuteComponent, 0.5)
        XCTAssertEqual(TimeInterval(86460).secondComponent, 0)
        XCTAssertEqual(TimeInterval(86460).minuteComponent, 1)
        
        let components = TimeInterval(86460).dateComponents
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 1)
        XCTAssertEqual(components.second, 0)
    }
}
