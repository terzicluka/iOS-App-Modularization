import UIKit
import RxSwift
import RxCocoa
import TVShowsCore

public final class LoginViewController: UIViewController {

    // MARK: - Constants -

    private enum LoginViewControllerConstants {
        enum UserInterface {
            static let placeholderColor: UIColor = .white.withAlphaComponent(0.5)
            static let disabled: UIColor = .white.withAlphaComponent(0.3)
            static let enabled: UIColor = .white
            static let cornerRadius = Float(50)
        }
    }

    // MARK: - Outlets -

    @IBOutlet fileprivate weak var passwordField: UITextField!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet fileprivate weak var showPasswordToggleButton: UIButton!

    // MARK: - Public properties -

    var presenter: LoginPresenterInterface!

    // MARK: - Private properties -

    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override public func viewDidLayoutSubviews() {
        setupUI()
    }

}

// MARK: - Extensions -

extension LoginViewController: LoginViewInterface {
}

private extension LoginViewController {

    func setupView() {
        let output = Login.ViewOutput(
            login: loginButton.rx.tap.asSignal(),
            register: registerButton.rx.tap.asSignal(),
            email: emailField.rx.text.asDriver(),
            password: passwordField.rx.text.asDriver()
        )

        handleShowPasswordTap()
        let input = presenter.configure(with: output)
        handleInput(input)
    }

    func handleInput(_ input: Login.ViewInput) {
        input
            .buttonsEnabled
            .drive(onNext: { [unowned loginButton, unowned registerButton] in
                loginButton?.isEnabled = $0
                let userInterfaceConstants = LoginViewControllerConstants.UserInterface.self
                loginButton?.backgroundColor = $0 ? userInterfaceConstants.enabled : userInterfaceConstants.disabled
                registerButton?.isEnabled = $0
            })
            .disposed(by: disposeBag)

    }

    func handleShowPasswordTap() {
        showPasswordToggleButton.rx.tap
            .bind(to: rx.secureEntryToggleBinder)
            .disposed(by: disposeBag)
    }

}

// MARK: - Setup UI -

extension LoginViewController {

    func setupUI() {
        let placeholderColor = LoginViewControllerConstants.UserInterface.placeholderColor
        emailField.setPlaceholderColor(color: placeholderColor)
        passwordField.setPlaceholderColor(color: placeholderColor)
        loginButton.setCornerRadius(with: LoginViewControllerConstants.UserInterface.cornerRadius)
    }

}

// MARK: Binder

extension Reactive where Base: LoginViewController {

    var secureEntryToggleBinder: Binder<Void> {
        return Binder(base) { viewController, _ in
            viewController.passwordField.isSecureTextEntry.toggle()
            viewController.showPasswordToggleButton.isSelected.toggle()
        }
    }

}
