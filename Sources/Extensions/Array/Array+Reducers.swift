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
    
    func ends(with suffix: Array) -> Bool {
        let count = self.count
        let startIndex = count - suffix.count
        
        guard startIndex >= 0 else {
            return false
        }
        
        return Array(self[startIndex..<count]) == suffix
    }
}
