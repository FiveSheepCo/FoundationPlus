import Foundation

public extension Dictionary where Value: Equatable {
    
    /// Returns an array of all keys with the given value.
    func keys(for value: Value) -> [Key] {
        var keys = [Key]()
        
        for keyValuePair in self where keyValuePair.value == value {
            keys.append(keyValuePair.key)
        }
        
        return keys
    }
}
