//
// This file contains additional sequence selectors.
// Selectors are operations that produce another sequence from a sequence.
//

public extension Sequence where Element: Equatable {
    
    /// Returns a new array with all occurrences of the specified element removed.
    ///
    /// - Parameter subject: The element to remove from the array.
    /// - Returns: A new array containing all elements of the original array except for those equal to `subject`.
    @inlinable
    func removingAll(subject: Element) -> [Element] {
        self.filter { $0 != subject }
    }
    
    /// Returns a new array with all occurrences of the specified element removed.
    ///
    /// - Parameter subject: The element to remove from the array.
    /// - Returns: A new array containing all elements of the original array except for those equal to `subject`.
    @available(*, deprecated, renamed: "removingAll", message: "Use `removingAll(subject:)` instead.")
    @inlinable
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
    @inlinable
    func removing(exactObject object: Element) -> [Element] {
        let erasedObject = object as AnyObject?
        return self.filter { $0 as AnyObject? !== erasedObject }
    }
}
