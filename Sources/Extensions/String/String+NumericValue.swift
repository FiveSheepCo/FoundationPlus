import Foundation

public extension String {
    
    /// The `Int` value of the string.
    @inlinable @inline(__always)
    var intValue: Int? {
        Int(self)
    }
    
    /// The `UInt` value of the string.
    @inlinable @inline(__always)
    var uintValue: UInt? {
        UInt(self)
    }
    
    /// The `Int8` value of the string.
    @inlinable @inline(__always)
    var int8Value: Int8? {
        Int8(self)
    }
    
    /// The `UInt8` value of the string.
    @inlinable @inline(__always)
    var uint8Value: UInt8? {
        UInt8(self)
    }
    
    /// The `Int16` value of the string.
    @inlinable @inline(__always)
    var int16Value: Int16? {
        Int16(self)
    }
    
    /// The `UInt16` value of the string.
    @inlinable @inline(__always)
    var uint16Value: UInt16? {
        UInt16(self)
    }
    
    /// The `Int32` value of the string.
    @inlinable @inline(__always)
    var int32Value: Int32? {
        Int32(self)
    }
    
    /// The `UInt32` value of the string.
    @inlinable @inline(__always)
    var uint32Value: UInt32? {
        UInt32(self)
    }
    
    /// The `Int64` value of the string.
    @inlinable @inline(__always)
    var int64Value: Int64? {
        Int64(self)
    }
    
    /// The `UInt64` value of the string.
    @inlinable @inline(__always)
    var uint64Value: UInt64? {
        UInt64(self)
    }
    
    /// The `Float` value of the string.
    @inlinable @inline(__always)
    var floatValue: Float? {
        Float(self)
    }
    
    /// The `Double` value of the string.
    @inlinable @inline(__always)
    var doubleValue: Double? {
        Double(self)
    }
}
