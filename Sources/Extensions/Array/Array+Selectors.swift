//
// This file contains additional array selectors.
// Selectors are operations that produce another sequence from a sequence.
//

import Foundation

public extension Array where Element: Equatable {
    
    /// Returns a new array with all occurrences of the specified element removed.
    ///
    /// - Parameter subject: The element to remove from the array.
    /// - Returns: A new array containing all elements of the original array except for those equal to `subject`.
    func removingAll(subject: Element) -> [Element] {
        self.filter { $0 != subject }
    }
    
    /// Returns a new array with all occurrences of the specified element removed.
    ///
    /// - Parameter subject: The element to remove from the array.
    /// - Returns: A new array containing all elements of the original array except for those equal to `subject`.
    @available(*, deprecated, renamed: "removeAll", message: "Use `removingAll(subject:)` instead.")
    func removing(subject: Element) -> [Element] {
        self.removingAll(subject: subject)
    }
    
    /// Returns a new array with all instances of the specified object removed.
    ///
    /// - Parameter object: The element to remove from the array.
    /// - Returns: A new array with all instances of the specified object removed.
    ///
    /// This function uses reference equality (===) to check for the object to be removed. This is particularly useful for reference types where you want to ensure the exact object instance is removed.
    ///
    /// Example:
    /// ```swift
    /// class MyClass {}
    /// let obj1 = MyClass()
    /// let obj2 = MyClass()
    /// let array = [obj1, obj2, obj1]
    /// let newArray = array.removing(exactObject: obj1)
    /// print(newArray.count) // Prints "1", since two instances of obj1 are removed
    /// ```
    func removing(exactObject object: Element) -> [Element] {
        let erasedObject = object as AnyObject?
        return self.filter { $0 as AnyObject? !== erasedObject }
    }
}

public extension Array where Element: Hashable {
    
    /// Enumeration to specify the deduplication mode.
    enum DeduplicationMode {
        
        /// Preserves the original order of elements in the array.
        /// This mode is slower compared to `notPreservingOrder` but keeps the original sequence order intact.
        case preservingOrder
        
        /// Does not preserve the order of elements.
        /// This mode offers better performance and is faster in removing duplicates, but the original order is lost.
        case notPreservingOrder
    }
    
    /// Removes duplicate elements from the array based on the specified deduplication mode.
    ///
    /// - Parameter mode: The mode of deduplication to use.
    /// - Returns: A new array with duplicates removed according to the specified mode.
    func removingDuplicates(_ mode: DeduplicationMode = .preservingOrder) -> [Element] {
        switch mode {
            case .preservingOrder:
                var seen = Set<Element>()
                return self.filter { seen.insert($0).inserted }
            case .notPreservingOrder:
                return Array(Set(self))
        }
    }
}
