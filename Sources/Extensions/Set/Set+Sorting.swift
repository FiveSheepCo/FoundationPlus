import Foundation

public extension Set {
    
    /// Sorts the set based on a specified key path of its elements.
    ///
    /// The sorting can be either in ascending or descending order, based on the `ascending` parameter.
    /// The method uses a generic `Comparable` type, allowing sorting on various types of properties.
    ///
    /// - Parameters:
    ///   - keyPath: A key path to a property of type `T` on the array's element type, where `T` is `Comparable`.
    ///   - ascending: A Boolean value that determines whether the sorting is in ascending order.
    ///                `true` for ascending order, and `false` for descending. The default is `true`.
    /// - Returns: A new array containing the elements of the original array, sorted based on the provided key path.
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        sorted { a, b in
            let isAscending = a[keyPath: keyPath] < b[keyPath: keyPath]
            return isAscending == ascending
        }
    }
}
