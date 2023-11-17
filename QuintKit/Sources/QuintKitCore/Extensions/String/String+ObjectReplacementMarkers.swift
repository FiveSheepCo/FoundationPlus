import Foundation

public extension String {
    /// Returns a new `String` without Unicode Object Replacement Markers (`0xfffc`).
    ///
    /// **Context**
    ///
    /// For some reason, the dictation feature inserts this marker at the end of the string.
    /// For RTL languages like arabic, it's at the beginning of the string.
    func removingObjectReplacementMarkers() -> String {
        self.replacingOccurrences(of: "\u{fffc}", with: "", options: String.CompareOptions.literal, range: nil)
    }
}
