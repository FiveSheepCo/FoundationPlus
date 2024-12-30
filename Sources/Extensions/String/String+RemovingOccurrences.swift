import Foundation

public extension String {
    
    /// Returns a new `String`, removing all occurrences of the specified `string`.
    ///
    /// - Parameter string: The string to be removed from the string.
    /// - Returns: A new string with all occurrences of `string` removed.
    func removingOccurrences(of string: String) -> String {
        replacingOccurrences(of: string, with: String.empty)
    }
    
    /// Returns a new `String`, removing all occurrences of the specified `string` from the start of the string.
    ///
    /// - Parameter string: The string to be removed from the start of the string.
    /// - Returns: A new string with all occurrences of `string` removed from the start of the string.
    func removingOccurrences(ofPrefix string: String) -> String {
        let targetStringUtf16Count = string.utf16.count
        var substring = self[startIndex..<endIndex]
        while substring.hasPrefix(string) {
            substring = self[String.Index(utf16Offset: targetStringUtf16Count, in: substring)..<substring.endIndex]
        }
        return String(substring)
    }
    
    /// Returns a new `String`, removing all occurrences of the specified `string` from the end of the string.
    ///
    /// - Parameter string: The string to be removed from the end of the string.
    /// - Returns: A new string with all occurrences of `string` removed from the end of the string.
    func removingOccurrences(ofSuffix string: String) -> String {
        let targetStringUtf16Count = string.utf16.count
        var substring = self[startIndex..<endIndex]
        while substring.hasSuffix(string) {
            let endIndex = substring.index(substring.endIndex, offsetBy: -targetStringUtf16Count)
            substring = self[substring.startIndex..<endIndex]
        }
        return String(substring)
    }
    
    // MARK: - Mutating versions
    
    /// Removes all occurrences of the specified `string`, mutating the string.
    ///
    /// - Parameter string: The string to be removed from the string.
    mutating func removeOccurrences(of string: String) {
        self = removingOccurrences(of: string)
    }
    
    /// Removes all occurrences of the specified `string` from the start of the string, mutating the string.
    ///
    /// - Parameter string: The string to be removed from the start of the string.
    mutating func removeOccurrences(ofPrefix string: String) {
        self = removingOccurrences(ofPrefix: string)
    }
    
    /// Removes all occurrences of the specified `string` from the end of the string, mutating the string.
    ///
    /// - Parameter string: The string to be removed from the end of the string.
    mutating func removeOccurrences(ofSuffix string: String) {
        self = removingOccurrences(ofSuffix: string)
    }
}
