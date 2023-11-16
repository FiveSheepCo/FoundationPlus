import SwiftUI

@available(iOS 14.0, *)
struct CompatibleOnChangeModifier<V: Equatable>: ViewModifier {
    var value: V
    var callback: (V) -> Void
    
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content
                .onChange(of: value) { _ , newValue in
                    callback(newValue)
                }
        } else {
            content
                .onChange(of: value, perform: { newValue in
                    callback(newValue)
                })
        }
    }
}

@available(iOS 14.0, *)
extension View {
    
    /// Adds a modifier for this view that fires an action when a specific value changes.
    ///
    /// Defaults to the deprecated `onChange` signature:
    /// ```swift
    /// onChange(of: _, perform: (Equatable) -> Void)
    /// ```
    /// Uses the new signature if available (`iOS 17.0, *`):
    /// ```swift
    /// onChange(of: _, action: (Equatable, Equatable) -> Void)
    /// ```
    ///
    /// - NOTE: Only supports the `newValue` parameter in the callback.
    public func compatibleOnChange<V: Equatable>(of value: V, callback: @escaping (V) -> Void) -> some View {
        modifier(CompatibleOnChangeModifier(value: value, callback: callback))
    }
}
