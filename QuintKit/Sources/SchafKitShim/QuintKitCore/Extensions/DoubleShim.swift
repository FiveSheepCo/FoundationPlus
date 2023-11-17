import Foundation

public extension Double {
    
    /**
     Returns a string representing the receiver, respecting the current locale.
     
     Example usage:
     ```swift
     let number: Double = 12.123
     number.toFormattedString() // "12.12"
     number.toFormattedString(decimals: 0) // "12"
     number.toFormattedString(decimals: 2) // "12.12"
     number.toFormattedString(decimals: 3) // "12.123"
     number.toFormattedString(decimals: 4) // "12.123"
     ```
    
     - Parameters:
       - decimals: The maximum number of decimals to display. Standard rounding is applied. The default is `2`.
       - separatesThousands: Whether thousands should be separated by the standard thousand separator of the current locale (e.g. `.` in english).
       - locale: The locale to use for the string representation of the number.
    */
    func toFormattedString(decimals: Int = 2, separatesThousands: Bool = true, locale: Locale = .autoupdatingCurrent) -> String {
        self.toFormattedString(
            .variable(
                minFractionalDigits: 0,
                maxFractionalDigits: decimals,
                separatesThousands: separatesThousands,
                locale: locale
            )
        )
    }
}
