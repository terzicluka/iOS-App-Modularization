import UIKit
import MBProgressHUD

public protocol WireframeInterface: AnyObject, Progressable {
}

open class BaseWireframe<ViewController> where ViewController: UIViewController {

    private unowned var _viewController: ViewController

    // We need it in order to retain view controller reference upon first access
    private var temporaryStoredViewController: ViewController?

    public init(viewController: ViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }

}

extension BaseWireframe: WireframeInterface { }

public extension BaseWireframe {

    var viewController: ViewController {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }

}

public extension UIViewController {

    func presentWireframe<ViewController>(
        _ wireframe: BaseWireframe<ViewController>,
        animated: Bool = true,
        completion: (() -> Void)? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }

}

public extension UINavigationController {

    func pushWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe<ViewController>(_ wireframe: BaseWireframe<ViewController>, animated: Bool = true) {
        setViewControllers([wireframe.viewController], animated: animated)
    }

}
