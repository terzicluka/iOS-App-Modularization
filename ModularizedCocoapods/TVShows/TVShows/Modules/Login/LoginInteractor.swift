import Foundation
import RxSwift
import TVShowsCore

final class LoginInteractor {
    private let service: APIService
    private let sessionManager: SessionManager

    init(service: APIService = APIService.instance, sessionManager: SessionManager = .default) {
        self.service = service
        self.sessionManager = sessionManager
    }
}

// MARK: - LoginInteractorInterface Extension -

extension LoginInteractor: LoginInteractorInterface {

    func request(email: String, password: String, router: LoginRouter) -> Single<Void> {
        let request: Single<(UserResponse, Dictionary<String, String>?)> = service.rx.request(
            UserResponse.self,
            router: router,
            session: sessionManager.session,
            validators: [.custom(LoginStatusValidator()), .default]
        )

        return request
            .do(onSuccess: { [unowned self] in saveHeaders(headers: $0.1) })
            .map { _ in () }
    }

    func validateEmail(in email: String?) -> Bool {
        guard let email else { return false }
        return email.contains(Validation.emailPattern)
    }

}

// MARK: - Utility methods -

extension LoginInteractor {

    private func saveHeaders(headers: [String: String]?) {
        guard let headers else { return }
        guard let authInfo = try? AuthInfo.init(from: headers) else { return }
        AuthInfoManager.instance.authInfo = authInfo
    }

}
