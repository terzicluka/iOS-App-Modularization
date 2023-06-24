import Alamofire

final class UserRouter: Router {

    private enum APIUrl {
        static let userPath = "/users/me"
    }

}

extension UserRouter {

    static func getUserInfo() -> UserRouter {

        return UserRouter(
            baseUrl: Constants.baseUrl,
            path: APIUrl.userPath,
            method: .get
        )
    }

}
