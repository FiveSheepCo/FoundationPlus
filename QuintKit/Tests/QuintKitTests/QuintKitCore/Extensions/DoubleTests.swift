import XCTest
@testable import QuintKitCore

final class Core__DoubleTests: XCTestCase {
    
    func testToString() throws {
        XCTAssertEqual(10.0.toString, "10.0")
        XCTAssertEqual(10.5.toString, "10.5")
    }
    
    func testToFormattedString() throws {
        let en_US = Locale(languageCode: .english)
        let de_DE = Locale(languageCode: .german)
        XCTAssertEqual(10.0.toFormattedString(.natural), "10")
        XCTAssertEqual(10.5.toFormattedString(.natural), "10.5")
        XCTAssertEqual(10.123.toFormattedString(.natural), "10.12")
        XCTAssertEqual(10.0.toFormattedString(.fixed(fractionalDigits: 2, locale: en_US)), "10.00")
        XCTAssertEqual(10.5.toFormattedString(.fixed(fractionalDigits: 2, locale: en_US)), "10.50")
        XCTAssertEqual(1000.toFormattedString(.fixed(fractionalDigits: 2, separatesThousands: true, locale: en_US)), "1,000.00")
        XCTAssertEqual(1000.toFormattedString(.fixed(fractionalDigits: 2, separatesThousands: true, locale: de_DE)), "1.000,00")
        XCTAssertEqual(1000.toFormattedString(.variable(minFractionalDigits: 1, maxFractionalDigits: 3, separatesThousands: true, locale: en_US)), "1,000.0")
        XCTAssertEqual(1000.12.toFormattedString(.variable(minFractionalDigits: 1, maxFractionalDigits: 3, separatesThousands: true, locale: en_US)), "1,000.12")
        XCTAssertEqual(1000.12345.toFormattedString(.variable(minFractionalDigits: 1, maxFractionalDigits: 3, separatesThousands: true, locale: en_US)), "1,000.123")
        XCTAssertEqual(1000.toFormattedString(.fixed(fractionalDigits: 2, separatesThousands: true, locale: de_DE)), "1.000,00")
    }
}
