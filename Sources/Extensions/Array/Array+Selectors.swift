//
// This file contains additional array selectors.
// Selectors are operations that produce another sequence from a sequence.
//

import Foundation

public extension Array where Element: Equatable {
    
    /// Returns a new array with all occurrences of the specified element removed.
    ///
    /// - Parameter subject: The element to remove from the array.
    /// - Returns: A new array containing all elements of the original array except for those equal to `subject`.
    func removingAll(subject: Element) -> [Element] {
        self.filter { $0 != subject }
    }
}

public extension Array where Element: Hashable {
    
    /// Enumeration to specify the deduplication mode.
    enum DeduplicationMode {
        
        /// Preserves the original order of elements in the array.
        /// This mode is slower compared to `notPreservingOrder` but keeps the original sequence order intact.
        case preservingOrder
        
        /// Does not preserve the order of elements.
        /// This mode offers better performance and is faster in removing duplicates, but the original order is lost.
        case notPreservingOrder
    }
    
    /// Removes duplicate elements from the array based on the specified deduplication mode.
    ///
    /// - Parameter mode: The mode of deduplication to use.
    /// - Returns: A new array with duplicates removed according to the specified mode.
    func removingDuplicates(_ mode: DeduplicationMode = .preservingOrder) -> [Element] {
        switch mode {
            case .preservingOrder:
                var seen = Set<Element>()
                return self.filter { seen.insert($0).inserted }
            case .notPreservingOrder:
                return Array(Set(self))
        }
    }
}
