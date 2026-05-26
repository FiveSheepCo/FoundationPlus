import Foundation

extension Swift.String: Swift.Identifiable {
    
    /// The `id` of the string is the string itself.
    @inlinable @inline(__always)
    public var id: Self {
        self
    }
}
