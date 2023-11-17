import Foundation

public extension Double {
    
    /// Defines styles for formatting numbers, offering various options for fractional digits and thousands separators.
    ///
    /// `FormattingStyle` provides different options to format numbers in a way that suits different use cases.
    /// It includes natural formatting with optional fractional digits, fixed formatting for a consistent number
    /// of fractional digits, and variable formatting for a range of fractional digits.
    ///
    /// - `natural`: Formats numbers naturally, using the current locale.
    ///   It defaults to a maximum of two fractional digits and uses thousands separators.
    ///   It's suited for displaying numbers in a user-friendly way.
    /// - `fixed`: Applies fixed fractional digit formatting, ideal for scenarios requiring consistent precision.
    ///   Parameters allow customization of fractional digits, thousands separator, and locale.
    /// - `variable`: Offers variable fractional digit formatting, balancing precision and readability.
    ///   Parameters enable specifying a range for fractional digits, thousands separator, and locale.
    ///
    /// Each case is designed to handle different formatting needs, ensuring numbers are presented in a clear,
    /// locale-aware manner suitable for various applications.
    enum FormattingStyle {
        /// Natural number formatting using the current locale,
        /// with a maximum of two fractional digits and separators
        /// between groupings of three (thousands).
        ///
        /// Examples:
        /// ```swift
        /// 12      // becomes "12"         (using en_US locale)
        /// 12.5    // becomes "12.5"       (using en_US locale)
        /// 12.123  // becomes "12.12"      (using en_US locale)
        /// 1000    // becomes "1,000"      (using en_US locale)
        /// 1000.5  // becomes "1,000.5"    (using en_US locale)
        /// ```
        case natural
        
        /// Advanced number formatting with a fixed amount of fractional digits.
        ///
        /// Examples (using default configuration):
        /// ```swift
        /// 12      // becomes "12.00"      (using en_US locale)
        /// 12.5    // becomes "12.50"      (using en_US locale)
        /// 12.123  // becomes "12.12"      (using en_US locale)
        /// ```
        case fixed(fractionalDigits: Int = 2, separatesThousands: Bool = true, locale: Locale = .autoupdatingCurrent)
        
        /// Advanced number formatting with a variable amount of fractional digits.
        ///
        /// Examples (using default configuration):
        /// ```swift
        /// 12      // becomes "12"         (using en_US locale)
        /// 12.5    // becomes "12.5"       (using en_US locale)
        /// 12.123  // becomes "12.12"      (using en_US locale)
        /// ```
        case variable(minFractionalDigits: Int = 0, maxFractionalDigits: Int = 2, separatesThousands: Bool = true, locale: Locale = .autoupdatingCurrent)
    }
    
    /**
     Returns a string representing the receiver.
     Provides a reasonable default, with options for advanced formatting.
     
     Example usage:
     ```swift
     let number: Double = 12.123
     number.toFormattedString(.natural) // "12"
     number.toFormattedString(.fixed(fractionalDigits: 2)) // "12.12"
     number.toFormattedString(.variable(minFractionalDigits: 0, maxFractionalDigits: 5)) // "12.123"
     ```
    
     - Parameters:
       - style: The formatting style to use. Defaults to `.natural`.
    */
    func toFormattedString(_ style: Self.FormattingStyle) -> String {
        let formatter = NumberFormatter()
        switch style {
            case .natural:
                formatter.maximumFractionDigits = 2
                formatter.usesGroupingSeparator = true
                formatter.groupingSize = 3
                formatter.locale = .autoupdatingCurrent
            case .fixed(let fractionalDigits, let separatesThousands, let locale):
                formatter.minimumFractionDigits = fractionalDigits
                formatter.maximumFractionDigits = fractionalDigits
                formatter.usesGroupingSeparator = separatesThousands
                formatter.groupingSize = 3
                formatter.locale = locale
            case .variable(let minFractionalDigits, let maxFractionalDigits, let separatesThousands, let locale):
                formatter.minimumFractionDigits = minFractionalDigits
                formatter.maximumFractionDigits = maxFractionalDigits
                formatter.usesGroupingSeparator = separatesThousands
                formatter.groupingSize = 3
                formatter.locale = locale
        }
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
