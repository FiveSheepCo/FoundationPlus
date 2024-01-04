//
// This file contains additional array mutators.
// Mutators are operations that modify the array in-place.
//

import Foundation

public extension Array where Element: Equatable {
    
    /// Modifies the array in place, removing all occurrences of the specified element.
    ///
    /// - Parameter subject: The element to remove from the array.
    mutating func removeAll(subject: Element) {
        for i in (0..<self.count).reversed() where self[i] == subject {
            self.remove(at: i)
        }
    }
}

public extension Array where Element: Hashable {
    
    /// Modifies the array in place, removing all duplicate elements.
    ///
    /// This mutating method removes all duplicate elements from the array.
    mutating func removeDuplicates() {
        self = removingDuplicates()
    }
}
