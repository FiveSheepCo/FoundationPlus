import Foundation

public extension Character {
    
    /// Returns a lowercased version of this character, if one is available.
    var lowercased: Character {
        String(self).lowercased().first ?? self
    }
    
    /// Returns an uppercased version of this character, if one is available.
    var uppercased: Character {
        String(self).uppercased().first ?? self
    }
}
