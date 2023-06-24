import Alamofire

public final class UserRouter: Router {

    private enum APIUrl {
        static let userPath = "/users/me"
    }

}

public extension UserRouter {

    static func getUserInfo() -> UserRouter {

        return UserRouter(
            baseUrl: Constants.baseUrl,
            path: APIUrl.userPath,
            method: .get
        )
    }

}
