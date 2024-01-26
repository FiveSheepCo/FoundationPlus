//
// This file contains additional array mutators.
// Mutators are operations that modify the array in-place.
//

import Foundation

public extension Array where Element: Equatable {
    
    /// Modifies the array in place, removing all instances of the subject.
    ///
    /// - Parameter subject: The element to remove from the array.
    @available(*, deprecated, renamed: "removeAll", message: "Use `removeAll(subject:)` instead.")
    mutating func remove(subject: Element) {
        self.removeAll(subject: subject)
    }
    
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
    mutating func removeDuplicates() {
        self = removingDuplicates()
    }
}
