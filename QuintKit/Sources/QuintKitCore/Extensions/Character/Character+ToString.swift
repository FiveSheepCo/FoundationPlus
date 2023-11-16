import Foundation

public extension Character {
    
    /**
     Converts the character into a string.
     
     This property provides a convenient way to convert a `Character` to a `String`.
     It's particularly useful when you need to perform operations that are specific to strings on a single character.
     
     Example usage:
     ```swift
     let char: Character = "A"
     let stringRepresentation = char.toString // "A"
     ```
     
     - Remark: This property enables more ergonomic optional chaining for character-to-string conversion.
     
     - Returns: A `String` containing only the receiver character.
    */
    var toString: String {
        String(self)
    }
}
