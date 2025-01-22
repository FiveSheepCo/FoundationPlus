import Foundation

public extension Array {
    
    /// Sorts the array based on a specified key path of its elements.
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

    /// Sorts the array based on a primary key path of its elements first, and a secondary key path second.
    ///
    /// This is useful when the primary comparison is prone to collisions.
    ///
    /// - Parameters:
    ///   - primary: A key path to a `Comparable` property of the array's `Element` type.
    ///   - ascending: A Boolean value that determines whether the sorting is in ascending order.
    ///   - secondary: A key path to a `Comparable` property of the array's `Element` type.
    ///   - secondaryAscending: A Boolean value that determines whether the secondary sorting is in ascending order.
    func sorted(
        by primary: KeyPath<Element, some Comparable>,
        ascending: Bool = true,
        secondary: KeyPath<Element, some Comparable>,
        secondaryAscending: Bool = true
    ) -> [Element] {
        sorted { a, b in
            let primA = a[keyPath: primary]
            let primB = b[keyPath: primary]
            if primA == primB {
                return (a[keyPath: secondary] < b[keyPath: secondary]) == secondaryAscending
            } else {
                return (primA < primB) == ascending
            }
        }
    }

    /// Sorts the array based on a primary key path of its elements first, a secondary key path second,
    /// and a tertiary key path third.
    ///
    /// This is useful when both the primary and secondary comparisons are prone to collisions.
    ///
    /// - Parameters:
    ///   - primary: A key path to a `Comparable` property of the array's `Element` type.
    ///   - ascending: A Boolean value that determines whether the sorting is in ascending order.
    ///   - secondary: A key path to a `Comparable` property of the array's `Element` type.
    ///   - secondaryAscending: A Boolean value that determines whether the secondary sorting is in ascending order.
    ///   - tertiary: A key path to a `Comparable` property of the array's `Element` type.
    ///   - tertiaryAscending: A Boolean value that determines whether the tertiary sorting is in ascending order.
    func sorted(
        by primary: KeyPath<Element, some Comparable>,
        ascending: Bool = true,
        secondary: KeyPath<Element, some Comparable>,
        secondaryAscending: Bool = true,
        tertiary: KeyPath<Element, some Comparable>,
        tertiaryAscending: Bool = true
    ) -> [Element] {
        sorted { a, b in
            let primA = a[keyPath: primary]
            let primB = b[keyPath: primary]
            if primA == primB {
                let secA = a[keyPath: secondary]
                let secB = b[keyPath: secondary]
                if secA == secB {
                    return (a[keyPath: tertiary] < b[keyPath: tertiary]) == tertiaryAscending
                } else {
                    return (secA < secB) == secondaryAscending
                }
            } else {
                return (primA < primB) == ascending
            }
        }
    }
}
