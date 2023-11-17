import Foundation

public extension Collection {
    
    /// Creates an iterator over the collection that yields pairs of indices and elements.
    ///
    /// This method provides an iterator that returns each element of the collection, along with its
    /// corresponding index. This is particularly useful for collections where the index type is not an
    /// integer, such as dictionaries or custom collections. The iterator continues until it has traversed
    /// the entire collection.
    ///
    /// The method uses lazy evaluation, where the elements and their indices are only computed as
    /// needed during iteration. This approach is efficient for large collections or when only part of
    /// the collection may be traversed.
    ///
    /// Example usage:
    /// ```
    /// let array = ["a", "b", "c"]
    /// for (index, element) in array.indexed() {
    ///     print("\(index): \(element)")
    /// }
    /// ```
    ///
    /// - Returns: An `AnyIterator` yielding pairs of the form `(index: Index, element: Element)`.
    func indexed() -> AnyIterator<(index: Index, element: Element)> {
        var index = self.startIndex
        
        return AnyIterator({
            
            // Guard against empty collection and end of collection
            guard !self.isEmpty && index != self.endIndex else { return nil }
            
            // Retrieve the current element
            let currentIndex = index
            let result = self[currentIndex]
            
            // Advance to the next index in the collection
            index = self.index(after: index)
            
            // Return the (Index, Element)-pair
            return (currentIndex, result)
        })
    }
}
