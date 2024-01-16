import Foundation

public extension String {
    
    /// Returns the individual lines of the string.
    var lines: [String] {
        components(separatedBy: .newlines)
    }
}
