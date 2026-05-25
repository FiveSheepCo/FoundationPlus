//
// This file contains additional collection selectors.
// Selectors are operations that produce another sequence from a sequence.
//

public extension Collection {
    
    /// Returns a new array with the specified element appended to the end.
    ///
    /// - Parameter element: The element to append.
    /// - Returns: A new array containing all elements of the original array followed by the appended element.
    /// - Complexity: `O(n + 1)`, where n is the length of the original array.
    func appending(_ element: Element) -> [Element] {
        var arr = [Element]()
        arr.reserveCapacity(self.count + 1)
        arr.append(contentsOf: self)
        arr.append(element)
        return arr
    }

    /// Returns a new array with the specified elements appended to the end.
    ///
    /// - Parameter element: The element to append.
    /// - Returns: A new array containing all elements of the original array followed by the appended elements.
    /// - Complexity: `O(n + m)`, where n is the length of the original array and m is the length of the contents array.
    func appending(contentsOf contents: [Element]) -> [Element] {
        var arr = [Element]()
        arr.reserveCapacity(self.count + contents.count)
        arr.append(contentsOf: self)
        arr.append(contentsOf: contents)
        return arr
    }
}
