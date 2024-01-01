import Foundation

public extension Collection {
    
    /// Returns nil if the collection is empty, otherwise returns itself.
    var nilIfEmpty: Self? {
        if self.isEmpty { nil } else { self }
    }
}
