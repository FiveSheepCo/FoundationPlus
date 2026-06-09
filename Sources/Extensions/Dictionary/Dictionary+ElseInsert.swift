import Foundation

public extension Dictionary {
    
    /// Get the value corresponding to `key`, or else insert `newValue`.
    ///
    /// - Parameters:
    ///   - key: The key to be used for lookup.
    ///   - newValue: The value to be inserted if the key doesn't exist.
    mutating func get(_ key: Key, elseInsert newValue: @autoclosure () -> Value) -> Value {
        if let value = self[key] {
            return value
        } else {
            let  value = newValue()
            self[key] = value
            return value
        }
    }
}
