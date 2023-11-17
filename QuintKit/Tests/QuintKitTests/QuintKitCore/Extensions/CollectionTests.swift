import XCTest
@testable import QuintKitCore

final class Core__CollectionTests: XCTestCase {
    
    func testIndexedArray() throws {
        let subject = [1, 2, 3]
        
        for (index, element) in subject.indexed() {
            XCTAssertEqual(subject[index], element)
        }
        
        let iterator = subject.indexed()
        ({ let next = iterator.next(); XCTAssertEqual(next?.index, 0); XCTAssertEqual(next?.element, 1); })()
        ({ let next = iterator.next(); XCTAssertEqual(next?.index, 1); XCTAssertEqual(next?.element, 2); })()
        ({ let next = iterator.next(); XCTAssertEqual(next?.index, 2); XCTAssertEqual(next?.element, 3); })()
        XCTAssertNil(iterator.next())
    }
}
