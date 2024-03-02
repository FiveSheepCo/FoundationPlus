import XCTest

@testable import FoundationPlus

final class SequenceTests: XCTestCase {
    
    func testRemovingNilValues() {
        XCTAssertEqual([1, nil, 2].removingNilValues(), [1, 2])
    }
    
    func testAsyncMap() async {
        let subject = [1, 2, 3, 4, 5]
        
        let result = await subject.asyncMap {
            await Task.yield()
            return String($0)
        }
        
        XCTAssertEqual(result, ["1", "2", "3", "4", "5"])
    }
    
    func testAsyncFilter() async {
        let subject = [1, 2, 3, 4, 5]
        
        let result = await subject.asyncFilter {
            await Task.yield()
            return $0 % 2 == 1
        }
        
        XCTAssertEqual(result, [1, 3, 5])
    }
    
    func testAsyncReduce() async {
        let subject = [1, 2, 3, 4, 5]
        
        let result = await subject.asyncReduce(0) { accum, value in
            await Task.yield()
            return accum + value
        }
        
        XCTAssertEqual(result, 15)
    }
    
    func testParallelMap() async throws {
        let subject = Array(repeating: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], count: 10).flatMap { $0 }
        
        let result = await subject.parallelMap { String($0) }
        let traditionalResult = subject.map { String($0) }
        
        XCTAssertEqual(result, traditionalResult)
    }
    
    func testParallelFilter() async throws {
        let subject = Array(repeating: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], count: 1000).flatMap { $0 }
        
        let result = try await subject.parallelFilter { $0 % 2 == 0 }
        let traditionalResult = subject.filter { $0 % 2 == 0 }
        
        XCTAssertEqual(result, traditionalResult)
    }
}
