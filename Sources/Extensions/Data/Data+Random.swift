import Foundation

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)

public extension Data {
    
    /// Initialize data with secure random numbers.
    ///
    /// - Parameter count: The number of random bytes.
    init (randomCount count: Int) {
        var bytes = [Int8](repeating: 0, count: count)
        
        _ = SecRandomCopyBytes(kSecRandomDefault, count, &bytes)
        
        self.init(bytes: &bytes, count: count)
    }
}

#endif
