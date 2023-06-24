import UIKit
import RxSwift
import RxCocoa

protocol LoginWireframeInterface: WireframeInterface {
    func navigateToHome()
}

protocol LoginViewInterface: ViewInterface {
}

protocol LoginPresenterInterface: PresenterInterface {
    func configure(with output: Login.ViewOutput) -> Login.ViewInput
}

protocol LoginInteractorInterface: InteractorInterface {
    func request(email: String, password: String, router: LoginRouter) -> Single<Void>
    func validateEmail(in email: String?) -> Bool
}

enum Login {

    struct ViewOutput {
        let login: Signal<Void>
        let register: Signal<Void>
        let email: Driver<String?>
        let password: Driver<String?>
    }

    struct ViewInput {
        let buttonsEnabled: Driver<Bool>
    }

}
