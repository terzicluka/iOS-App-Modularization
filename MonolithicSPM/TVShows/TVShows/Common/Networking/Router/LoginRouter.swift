import Foundation
import Alamofire

final class LoginRouter: Router {

    private enum APIUrl {
        static let loginPath = "/users/sign_in"
        static let registerPath = "/users/"
    }

    static func login(email: String, password: String) -> LoginRouter {
        let params = [
            "email": email,
            "password": password
        ]

        let encodedParams = EncodableParams(encoding: JSONEncoding.default, parameters: params)
        return LoginRouter(
            baseUrl: Constants.baseUrl,
            path: APIUrl.loginPath,
            method: .post,
            encodableParams: [encodedParams]
        )
    }

    static func register(email: String, password: String) -> LoginRouter {
        let params = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]

        let encodedParams = EncodableParams(encoding: JSONEncoding.default, parameters: params)
        return LoginRouter(
            baseUrl: Constants.baseUrl,
            path: APIUrl.registerPath,
            method: .post,
            encodableParams: [encodedParams]
        )
    }

}
