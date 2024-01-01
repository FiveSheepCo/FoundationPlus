import Foundation

public extension Dictionary {
    
    /// Returns a dictionary merging the keys and values of both dictionaries.
    ///
    /// - Important: In case of key conflict, the value in the right-hand dictionary wins.
    static func +(left: Self, right: Self) -> Self {
        var final = left
        for keyValuePair in right {
            final[keyValuePair.key] = keyValuePair.value
        }
        return final
    }
    
    /// Merges the right-hand dictionary in the left-hand one.
    ///
    /// - Important : In case of key conflict, the value in the right-hand dictionary wins.
    static func +=(left: inout [Key : Value], right: [Key : Value]) {
        left = left + right
    }
}
