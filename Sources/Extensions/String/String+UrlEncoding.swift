import Foundation

private extension String {
    
    /// A character set containing allowed characters for percent-encoding.
    var urlAllowed: CharacterSet {
        CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-._~")) // as per RFC 3986
    }
}

public extension String {
    
    /// A percent-encoded version of the string using the allowed character set for URLs.
    ///
    /// If encoding fails, the original string is returned.
    var urlEncoded: String {
        addingPercentEncoding(withAllowedCharacters: urlAllowed) ?? self
    }
    
    /// A percent-decoded version of the string.
    ///
    /// If decoding fails, the original string is returned.
    var urlDecoded: String {
        removingPercentEncoding ?? self
    }
    
    // MARK: - Mutating versions
    
    /// Percent-encodes the string using the allowed character set for URLs.
    ///
    /// Does nothing if encoding fails.
    mutating func urlEncode() {
        if let string = addingPercentEncoding(withAllowedCharacters: urlAllowed) {
            self = string
        }
    }
    
    /// Percent-decodes the string.
    ///
    /// Does nothing if decoding fails.
    mutating func urlDecode() {
        if let string = removingPercentEncoding {
            self = string
        }
    }
}
