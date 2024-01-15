import XCTest

@testable import FoundationPlus

final class ArrayTests: XCTestCase {
    
    func testAnySatisfy() {
        let subject = [1, 3, 5, 7, 10]
        
        XCTAssertTrue(subject.anySatisfy { $0 % 2 == 0 })
        XCTAssertFalse(subject.anySatisfy { $0 <= 0 })
    }
    
    func testNoneSatisfy() {
        let subject = [1, 3, 5, 7, 9]
        
        XCTAssertTrue(subject.noneSatisfy { $0 % 2 == 0 })
        XCTAssertFalse(subject.noneSatisfy { $0 >= 0 })
    }
    
    func testMinMax() {
        let subject = [-5, -3, 0, 4, 7]
        
        let result = subject.minmax()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.min, -5)
        XCTAssertEqual(result?.max, 7)
    }
    
    func testGreatestMagnitude() {
        let subject = [-150, -70, -5, 0, 30, 120]
        
        let result = subject.greatestMagnitude()
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result, .some(150))
    }
    
    func testRemovingDuplicates() {
        let subject = [0, 0, 1, 2, 3, 3, 3, 4, 5, 5, 6, 7]
        
        XCTAssertEqual(subject.removingDuplicates(.preservingOrder), [0, 1, 2, 3, 4, 5, 6, 7])
        XCTAssertEqual(subject.removingDuplicates(.notPreservingOrder).sorted(), [0, 1, 2, 3, 4, 5, 6, 7])
    }
    
    func testRemovingSubject() {
        let subject = [1, 5, 2, 3, 4, 5, 6, 5, 7, 8, 9]
        
        XCTAssertEqual(subject.removingAll(subject: 5), [1, 2, 3, 4, 6, 7, 8, 9])
    }
    
    func testRemoveSubject() {
        var subject = [1, 5, 2, 3, 4, 5, 6, 5, 7, 8, 9]
        
        subject.removeAll(subject: 5)
        XCTAssertEqual(subject, [1, 2, 3, 4, 6, 7, 8, 9])
    }
    
    func testSortedByKeyPath() {
        let subject = [1, 3, 2, 4, 6, 5, 8, 7, 9, 0]
        
        XCTAssertEqual(subject.sorted(by: \.self), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    }
}
