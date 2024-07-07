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
    
    func testEndsWith() {
        let subject = [1, 2, 3, 4, 5]
        
        XCTAssertTrue(subject.ends(with: []))
        XCTAssertTrue(subject.ends(with: [5]))
        XCTAssertTrue(subject.ends(with: [4, 5]))
        XCTAssertTrue(subject.ends(with: [3, 4, 5]))
        XCTAssertTrue(subject.ends(with: subject))
        
        XCTAssertFalse(subject.ends(with: [3, 4]))
    }
    
    func removeFirstIfExists() {
        var subject = [1, 2, 3, 4, 5]
        
        XCTAssertEqual(subject.removeFirstIfExists(), 1)
        XCTAssertEqual(subject, [2, 3, 4, 5])
    }
    
    func testContainsExactObject() {
        class X: Equatable {
            static func == (lhs: X, rhs: X) -> Bool {
                true
            }
            init() {}
        }
        let a = X()
        let b = X()
        let c = X()
        let subject = [a, b, c]
        
        XCTAssertTrue(subject.contains(exactObject: a))
        XCTAssertTrue(subject.contains(exactObject: b))
        XCTAssertTrue(subject.contains(exactObject: c))
        XCTAssertFalse(subject.contains(exactObject: X()))
    }
    
    func testRemoveExactObject() {
        class X: Equatable {
            static func == (lhs: X, rhs: X) -> Bool {
                true
            }
            init() {}
        }
        let a = X()
        let b = X()
        let c = X()
        
        var subject = [a, b, c]
        subject.remove(exactObject: b)
        subject.remove(exactObject: X())
        
        XCTAssertTrue(subject.count == 2)
        XCTAssertIdentical(subject[0], a)
        XCTAssertIdentical(subject[1], c)
    }
    
    func testRemovingExactObject() {
        class X: Equatable {
            static func == (lhs: X, rhs: X) -> Bool {
                true
            }
            init() {}
        }
        let a = X()
        let b = X()
        let c = X()
        
        let subject = [a, b, c]
        let newSubject = subject.removing(exactObject: b)
        
        XCTAssertTrue(newSubject.count == 2)
        XCTAssertIdentical(newSubject[0], a)
        XCTAssertIdentical(newSubject[1], c)
    }
}
