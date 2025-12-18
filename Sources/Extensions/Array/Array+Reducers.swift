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

    /// Finds the minimum element in the array.
    func min<T: Comparable>(byValue value: KeyPath<Element, T>) -> Element? {
        self.min(by: {
            $0[keyPath: value] < $1[keyPath: value]
        })
    }

    /// Finds the maximum element in the array.
    func max<T: Comparable>(byValue value: KeyPath<Element, T>) -> Element? {
        self.max(by: {
            $0[keyPath: value] < $1[keyPath: value]
        })
    }

    /// Finds the minimum and maximum elements in the array.
    ///
    /// This method traverses the array to find the smallest and largest elements. If the array is empty,
    /// it returns `nil`. Otherwise, it returns a tuple containing the minimum and maximum elements.
    ///
    /// - Parameter value: A key path that specifies the property to compare.
    /// - Returns: An optional tuple representing the minimum and maximum elements in the array, or `nil`
    ///   if the array is empty.
    func minmax<T: Comparable>(byValue value: KeyPath<Element, T>) -> (min: T, max: T)? {
        guard let firstElement = self.first else { return nil }

        var min: T = firstElement[keyPath: value]
        var max: T = firstElement[keyPath: value]

        for e in self.dropFirst() {
            let value = e[keyPath: value]
            if value < min { min = value }
            if value > max { max = value }
        }

        return (min, max)
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

public extension Array where Element: BinaryInteger {

    /// The average (arithmetic mean) of all elements in the array.
    ///
    /// Returns `NaN` if the array is empty. The average is calculated by dividing the sum of all elements
    /// by the count of elements in the array. The result is returned as a `Double`.
    var average: Double {
        guard !self.isEmpty else {
            return Double.nan
        }

        let sum = self.reduce(0, +)
        return Double(sum) / Double(self.count)
    }

    /// The median value of the array.
    ///
    /// Returns `NaN` if the array is empty. The array is first sorted to compute the median.
    /// If the number of elements is odd, returns the middle element. If even, returns the average
    /// of the two middle elements. The result is returned as a `Double`.
    var median: Double {
        guard !self.isEmpty else {
            return Double.nan
        }

        let sorted = self.sorted()
        let midIndex = sorted.count / 2

        return if sorted.count % 2 == 0 {
            Double(sorted[midIndex - 1] + sorted[midIndex]) / 2.0
        } else {
            Double(sorted[midIndex])
        }
    }
}

public extension Array where Element: BinaryFloatingPoint {

    /// The average (arithmetic mean) of all elements in the array.
    ///
    /// Returns `NaN` if the array is empty. The average is calculated by dividing the sum of all elements
    /// by the count of elements in the array. The result is returned as a `Double`.
    var average: Double {
        guard !self.isEmpty else {
            return Double.nan
        }

        let sum = self.reduce(0, +)
        return Double(sum) / Double(self.count)
    }

    /// The median value of the array.
    ///
    /// Returns `NaN` if the array is empty. The array is first sorted to compute the median.
    /// If the number of elements is odd, returns the middle element. If even, returns the average
    /// of the two middle elements. The result is returned as a `Double`.
    var median: Double {
        guard !self.isEmpty else {
            return Double.nan
        }

        let sorted = self.sorted()
        let midIndex = sorted.count / 2

        return if sorted.count % 2 == 0 {
            Double(sorted[midIndex - 1] + sorted[midIndex]) / 2.0
        } else {
            Double(sorted[midIndex])
        }
    }
}
