import Foundation
import RxSwift
import RxCocoa
import TVShowsCore
import TVShowsCore

final class LoginPresenter {

    // MARK: - Private properties -

    private unowned let view: LoginViewInterface
    private let interactor: LoginInteractorInterface
    private let wireframe: LoginWireframeInterface
    private var disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    init(
        view: LoginViewInterface,
        interactor: LoginInteractorInterface,
        wireframe: LoginWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension LoginPresenter: LoginPresenterInterface {

    func configure(with output: Login.ViewOutput) -> Login.ViewInput {
        let buttonsEnabled = handleFields(email: output.email, password: output.password)

        handleLogin(buttonTap: output.login, email: output.email, password: output.password)
        handleRegister(buttonTap: output.register, email: output.email, password: output.password)

        return Login.ViewInput(buttonsEnabled: buttonsEnabled)
    }

}

// MARK: - Utility functions -

private extension LoginPresenter {

    func handle(_ remember: Signal<Void>) -> Driver<Bool> {
        remember.asDriver(onErrorDriveWith: .empty())
            .scan(false) { previousValue, _ in !previousValue }
            .startWith(false)
    }

    func handleFields(email: Driver<String?>, password: Driver<String?>) -> Driver<Bool> {
        Driver
            .combineLatest(email, password)
            .map({ [unowned self] email, password in
                guard password != nil else { return false }
                return interactor.validateEmail(in: email)
            })
    }

    func handleLogin(
        buttonTap: Signal<Void>,
        email: Driver<String?>,
        password: Driver<String?>
    ) {
        let email = email.compactMap { $0 }
        let password = password.compactMap { $0 }

        let inputs = Driver.combineLatest(email, password)

        buttonTap
            .withLatestFrom(inputs)
            .flatMap { [unowned self] in
                interactor
                    .request(email: $0, password: $1, router: LoginRouter.login(email: $0, password: $1))
                    .handleLoadingAndError(with: view)
                    .asDriver(onErrorDriveWith: .empty())
            }
            .drive(onNext: { [unowned wireframe] _ in wireframe.navigateToHome() })
            .disposed(by: disposeBag)
    }

    func handleRegister(
        buttonTap: Signal<Void>,
        email: Driver<String?>,
        password: Driver<String?>
    ) {
        let email = email.compactMap { $0 }
        let password = password.compactMap { $0 }

        let inputs = Driver.combineLatest(email, password)

        buttonTap
            .withLatestFrom(inputs)
            .flatMap { [unowned self] in
                interactor
                    .request(email: $0, password: $1, router: LoginRouter.register(email: $0, password: $1))
                    .handleLoadingAndError(with: view)
                    .asDriver(onErrorDriveWith: .empty())
            }
            .drive(onNext: { [unowned wireframe] _ in wireframe.navigateToHome() })
            .disposed(by: disposeBag)
    }

}
