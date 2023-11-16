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
}
