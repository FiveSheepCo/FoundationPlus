#if canImport(UIKit)

import UIKit

public extension UIViewController {
    
    /// Presents a given view controller using a private implementation.
    ///
    /// This private method provides a mechanism to present a view controller recursively.
    /// It checks if there is already a presented view controller. If so, it calls itself
    /// on the presented view controller, effectively chaining the presentation until a view
    /// controller with no currently presented view controller is found. Then, it presents
    /// the new view controller on this final view controller in the chain.
    ///
    /// - Parameter viewController: The `UIViewController` to be presented.
    ///
    /// Note: This function is unavailable in iOS application extensions and is meant for internal use only.
    ///
    /// Example usage (internal):
    /// ```swift
    /// self._present(anotherViewController)
    /// ```
    @available(iOSApplicationExtension, unavailable)
    internal func _present(_ viewController: UIViewController) {
        guard let presentedViewController = presentedViewController else {
            self.present(viewController)
            return
        }
        presentedViewController._present(viewController)
    }
    
    /// Presents a view controller animatedly.
    ///
    /// This convenience function presents a view controller with a default animation and no completion handler.
    /// It serves as a simplified way to present a view controller without specifying the animation and completion details.
    ///
    /// - Parameter viewController: The `UIViewController` to be presented.
    ///
    /// Example usage:
    /// ```swift
    /// someViewController.present(anotherViewController)
    /// ```
    func present(_ viewController: UIViewController){
        present(viewController, animated: true, completion: nil)
    }
}

#endif
