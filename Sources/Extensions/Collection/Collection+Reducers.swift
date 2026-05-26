//
// This file contains additional collection reducers.
// Reducers are operations that produce a single value from a sequence.
//

public extension Collection {
    
    /// Finds the minimum and maximum elements in the array.
    ///
    /// This method traverses the array to find the smallest and largest elements. If the array is empty,
    /// it returns `nil`. Otherwise, it returns a tuple containing the minimum and maximum elements.
    ///
    /// - Parameter value: A key path that specifies the property to compare.
    /// - Returns: An optional tuple representing the minimum and maximum elements in the array, or `nil`
    ///   if the array is empty.
    @inlinable
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

public extension Collection where Element: Comparable {

    /// Finds the minimum and maximum elements in the array.
    ///
    /// This method traverses the array to find the smallest and largest elements. If the array is empty,
    /// it returns `nil`. Otherwise, it returns a tuple containing the minimum and maximum elements.
    ///
    /// - Returns: An optional tuple representing the minimum and maximum elements in the array, or `nil`
    ///   if the array is empty.
    @inlinable
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

public extension Collection where Element: Comparable & SignedNumeric {
    
    /// Computes the element with the greatest magnitude in the array.
    ///
    /// This method calculates the element of the array that has the greatest absolute value.
    /// It returns `nil` if the array is empty.
    ///
    /// - Returns: An optional `Element` representing the element with the greatest magnitude, or `nil` if the
    ///   array is empty.
    @inlinable
    func greatestMagnitude() -> Element? {
        guard let (min, max) = self.minmax() else { return nil }
        return Swift.max(abs(min), abs(max))
    }
}

public extension Collection where Element: Equatable {
    
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
    @inlinable
    func hasSuffix<S>(_ suffix: S) -> Bool where S: Collection<Element> {
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
    @inlinable
    func ends<S>(with suffix: S) -> Bool where S: Collection<Element> {
        let endIndex = self.endIndex
        let startIndex = self.index(endIndex, offsetBy: -suffix.count)

        guard startIndex >= self.startIndex else {
            return false
        }
        
        return self[startIndex...].elementsEqual(suffix)
    }
}

public extension Collection where Element: BinaryInteger {

    /// The average (arithmetic mean) of all elements in the array.
    ///
    /// Returns `NaN` if the array is empty. The average is calculated by dividing the sum of all elements
    /// by the count of elements in the array. The result is returned as a `Double`.
    @inlinable
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
    @inlinable
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

public extension Collection where Element: BinaryFloatingPoint {

    /// The average (arithmetic mean) of all elements in the array.
    ///
    /// Returns `NaN` if the array is empty. The average is calculated by dividing the sum of all elements
    /// by the count of elements in the array. The result is returned as a `Double`.
    @inlinable
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
    @inlinable
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
