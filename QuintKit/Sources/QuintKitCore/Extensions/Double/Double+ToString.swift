import Foundation

public extension Double {
    
    /**
     Converts the number into a string.
     
     This property provides a convenient way to convert a `Double` to a `String`.
     
     Example usage:
     ```swift
     let number: Double = 12
     let stringRepresentation = number.toString // "12"
     ```
     
     - Remark: This property enables more ergonomic optional chaining for double-to-string conversion.
     
     - Returns: A `String` containing only the receiver number.
    */
    var toString: String {
        String(self)
    }
}
