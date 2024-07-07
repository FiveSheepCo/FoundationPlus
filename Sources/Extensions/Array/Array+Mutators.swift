//
// This file contains additional array mutators.
// Mutators are operations that modify the array in-place.
//

import Foundation

public extension Array {
    
    /// Modifies the array in place, removing and returning its first element, if it exists.
    mutating func removeFirstIfExists() -> Element? {
        if self.isEmpty { nil }
        else { self.removeFirst() }
    }
    
    /// Modifies the array in place, removing and returning its last element, if it exists.
    mutating func removeLastIfExists() -> Element? {
        if self.isEmpty { nil }
        else { self.removeLast() }
    }
    
    /// Removes the specified object from the collection by reference.
    ///
    /// - Parameter object: The object to be removed from the collection.
    /// - Note: This method compares objects by reference, not by value. If multiple instances of the object
    ///   exist in the collection, all instances will be removed.
    mutating func remove(exactObject object: Element) {
        let erasedObject = object as AnyObject?
        for i in (0..<self.count).reversed() {
            if self[i] as AnyObject? === erasedObject {
                self.remove(at: i)
            }
        }
    }
}

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
