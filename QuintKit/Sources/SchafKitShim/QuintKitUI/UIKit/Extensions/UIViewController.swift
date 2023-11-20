#if canImport(UIKit) && !os(watchOS)

import UIKit
import QuintKitUI

extension UIViewController.Container {
    
    // I'm very unsure if this is even needed, since `wrap` is `internal`.
    /// SchafKit shim for `Container.wrap`.
    func get(for controller: UIViewController) -> UIViewController {
        switch self {
        case .navigationController:
            UINavigationController(rootViewController: controller)
        }
    }
}

#endif
