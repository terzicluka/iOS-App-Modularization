import UIKit
import RxSwift
import RxCocoa

final class LoginWireframe: BaseWireframe<LoginViewController> {

    // MARK: - Constants -

    private enum Constants {
        enum Storyboard {
            static let login = "Login"
        }
    }

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: Constants.Storyboard.login, bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: LoginViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension LoginWireframe: LoginWireframeInterface {

    func navigateToHome() {
        navigationController?.setRootWireframe(HomeWireframe())
    }

}
