import XCTest
import Combine
@testable import QuintKitCore

final class EquatablePublishedTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    // Test that changes to the value are published when the value actually changes.
    func testPublishOnChange() {
        let expectation = XCTestExpectation(description: "Value change should be published")
        let testObject = TestClass()
        var receivedValues: [Int] = []

        testObject.$myProperty.sink { value in
            receivedValues.append(value)
            expectation.fulfill()
        }.store(in: &cancellables)

        testObject.myProperty = 2 // Different from initial value

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedValues, [1, 2], "Publisher should emit new value")
    }

    // Test that no changes are published when the value is set to the same value.
    func testNoPublishOnSameValue() {
        let expectation = XCTestExpectation()
        let testObject = TestClass()
        var receivedValues: [Int] = []

        testObject.$myProperty.sink { value in
            receivedValues.append(value)
            expectation.fulfill()
        }.store(in: &cancellables)

        testObject.myProperty = 1 // Same as initial value
        testObject.myProperty = 1
        testObject.myProperty = 1
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedValues, [1], "Publisher should not emit for the same value")
    }
}

extension EquatablePublishedTests {
    
    // Helper class to use in tests
    private class TestClass: ObservableObject {
        let objectWillChange = ObservableObjectPublisher()
        
        @EquatablePublished var myProperty: Int = 1
    }
}
