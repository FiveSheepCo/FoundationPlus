import Foundation

public extension String {
    
    /// Obtain a `String.Index` from an offset into the string.
    ///
    /// - Parameter offset: An `Int` value representing the offset from the start of the string.
    /// - Returns: A `String.Index` corresponding to the offset within the string.
    func indexAt(_ offset: Int) -> Index {
        index(startIndex, offsetBy: offset)
    }
    
    /// Obtain a `Range` of `String.Index` from an `NSRange` into the string.
    ///
    /// - Parameter range: An `NSRange` representing a range within the string.
    /// - Returns: A `Range<String.Index>` corresponding to the given `NSRange`.
    func indexRange(for range: NSRange) -> Range<String.Index> {
        indexAt(range.location)..<indexAt(range.location + range.length)
    }
    
    // MARK: - Subscripts
    
    /// Accesses the `Character` at the given integer offset.
    ///
    /// - Parameter offset: An `Int` value representing the offset from the start of the string.
    /// - Returns: The `Character` at the specified offset.
    subscript(_ offset: Int) -> Character {
        self[indexAt(offset)]
    }
    
    /// Accesses the substring in the given integer range.
    ///
    /// - Parameter range: A `Range<Int>` representing the range of characters.
    /// - Returns: A `Substring` containing the characters within the specified range.
    subscript(_ range: Range<Int>) -> Substring {
        self[indexAt(range.lowerBound)..<indexAt(range.upperBound)]
    }
    
    /// Accesses the substring in the given closed integer range.
    ///
    /// - Parameter range: A `ClosedRange<Int>` representing the range of characters.
    /// - Returns: A `Substring` containing the characters within the specified closed range.
    subscript(_ range: ClosedRange<Int>) -> Substring {
        self[indexAt(range.lowerBound)...indexAt(range.upperBound)]
    }
    
    /// Accesses the substring from the given lower bound to the end of the string.
    ///
    /// - Parameter range: A `PartialRangeFrom<Int>` representing the starting point of the range.
    /// - Returns: A `Substring` starting from the specified lower bound to the end of the string.
    subscript(_ range: PartialRangeFrom<Int>) -> Substring {
        self[indexAt(range.lowerBound)...]
    }
    
    /// Accesses the substring up to, but not including, the given upper integer bound.
    ///
    /// - Parameter range: A `PartialRangeUpTo<Int>` representing the upper bound of the range.
    /// - Returns: A `Substring` up to, but not including, the specified upper bound.
    subscript(_ range: PartialRangeUpTo<Int>) -> Substring {
        self[..<indexAt(range.upperBound)]
    }
    
    /// Accesses the substring through the given upper integer bound.
    ///
    /// - Parameter range: A `PartialRangeThrough<Int>` representing the upper bound of the range.
    /// - Returns: A `Substring` including characters up to and including the specified upper bound.
    subscript(_ range: PartialRangeThrough<Int>) -> Substring {
        self[...indexAt(range.upperBound)]
    }
    
    /// Accesses the substring specified by an `NSRange`.
    ///
    /// - Parameter range: An `NSRange` representing the range of characters.
    /// - Returns: A `Substring` corresponding to the specified `NSRange`.
    subscript(_ range: NSRange) -> Substring {
        self[indexRange(for: range)]
    }
}
