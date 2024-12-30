//
// This file contains additional array reducers.
// Reducers are operations that produce a single value from a sequence.
//

import Foundation

public extension Array {
    
    /// Returns a Boolean value indicating whether any element of a sequence satisfies a given predicate.
    ///
    /// This method iterates over the elements of the array, applying the `predicate` to each element.
    /// If any element satisfies the predicate, the method returns `true`. Otherwise, it returns `false`.
    ///
    /// - Parameter predicate: A closure that takes an element of the array as its argument and returns a Boolean value.
    /// - Returns: `true` if any element in the array satisfies the given predicate; otherwise, `false`.
    func anySatisfy(_ predicate: (Element) -> Bool) -> Bool {
        for item in self where predicate(item) {
            return true
        }
        return false
    }
    
    /// Returns a Boolean value indicating whether no element of a sequence satisfies a given predicate.
    ///
    /// This method iterates over the elements of the array, applying the `predicate` to each element.
    /// If any element satisfies the predicate, the method returns `false`. Otherwise, it returns `true`.
    ///
    /// - Parameter predicate: A closure that takes an element of the array as its argument and returns a Boolean value.
    /// - Returns: `true` if no element in the array satisfies the given predicate; otherwise, `false`.
    func noneSatisfy(_ predicate: (Element) -> Bool) -> Bool {
        for item in self where predicate(item) {
            return false
        }
        return true
    }
    
    ///
    /// Checks if the collection contains the specified object by reference.
    ///
    /// - Parameter object: The object to search for in the collection.
    /// - Returns: `true` if the collection contains the object, `false` otherwise.
    /// - Note: This method compares objects by reference, not by value.
    func contains(exactObject object: Element) -> Bool {
        let erasedObject = object as AnyObject?
        for e in self where e as AnyObject? === erasedObject {
            return true
        }
        return false
    }
}

public extension Array where Element: Comparable {

    /// Finds the minimum and maximum elements in the array.
    ///
    /// This method traverses the array to find the smallest and largest elements. If the array is empty,
    /// it returns `nil`. Otherwise, it returns a tuple containing the minimum and maximum elements.
    ///
    /// - Returns: An optional tuple representing the minimum and maximum elements in the array, or `nil`
    ///   if the array is empty.
    func minmax() -> (min: Element, max: Element)? {
        guard let firstElement = self.first else { return nil }
        
        var min: Element = firstElement
        var max: Element = firstElement
        
        for e in self.dropFirst() {
            if e < min { min = e }
            if e > max { max = e }
        }
        
        return (min, max)
    }
}

public extension Array where Element: Comparable & SignedNumeric {
    
    /// Computes the element with the greatest magnitude in the array.
    ///
    /// This method calculates the element of the array that has the greatest absolute value.
    /// It returns `nil` if the array is empty.
    ///
    /// - Returns: An optional `Element` representing the element with the greatest magnitude, or `nil` if the
    ///   array is empty.
    func greatestMagnitude() -> Element? {
        guard let (min, max) = self.minmax() else { return nil }
        return Swift.max(abs(min), abs(max))
    }
}

public extension Array where Element: Equatable {

    /// Checks if the array starts with the specified prefix.
    ///
    /// - Parameter prefix: An array of the same element type to check as the prefix.
    /// - Returns: `true` if the array starts with the specified prefix, `false` otherwise.
    ///
    /// Example:
    /// ```swift
    /// let array = [1, 2, 3, 4, 5]
    /// print(array.hasPrefix([1, 2])) // Prints "true"
    /// ```
    @inline(__always)
    func hasPrefix(_ prefix: Self) -> Bool {
        self.starts(with: prefix)
    }

    /// Checks if the array ends with the specified suffix.
    ///
    /// - Parameter suffix: An array of the same element type to check as the suffix.
    /// - Returns: `true` if the array ends with the specified suffix, `false` otherwise.
    ///
    /// Example:
    /// ```swift
    /// let array = [1, 2, 3, 4, 5]
    /// print(array.hasSuffix([4, 5])) // Prints "true"
    /// ```
    @inline(__always)
    func hasSuffix(_ suffix: Self) -> Bool {
        self.ends(with: suffix)
    }

    /// Checks if the array ends with the specified suffix.
    ///
    /// - Parameter suffix: An array of the same element type to check as the suffix.
    /// - Returns: `true` if the array ends with the specified suffix, `false` otherwise.
    ///
    /// This function compares the elements of the suffix with the elements at the end of the array to determine if they match.
    ///
    /// Example:
    /// ```swift
    /// let array = [1, 2, 3, 4, 5]
    /// print(array.ends(with: [4, 5])) // Prints "true"
    /// ```
    func ends(with suffix: Array) -> Bool {
        let count = self.count
        let startIndex = count - suffix.count

        guard startIndex >= 0 else {
            return false
        }
        
        return Array(self[startIndex..<count]) == suffix
    }
}
