import Alamofire

public final class HomeRouter: Router {

    private enum APIUrl {
        static let showsPath = "/shows"
        static let topRatedPath = "/shows/top_rated"
    }

}

public extension HomeRouter {

    static func getShowsRouter(page: Int) -> HomeRouter {
        let params = ["page": page]
        let encodedParams = EncodableParams(encoding: URLEncoding.default, parameters: params)

        return HomeRouter(
            baseUrl: Constants.baseUrl,
            path: APIUrl.showsPath,
            method: .get,
            encodableParams: [encodedParams]
        )
    }

    static func getTopRatedRouter() -> HomeRouter {
        return HomeRouter(
            baseUrl: Constants.baseUrl,
            path: APIUrl.topRatedPath,
            method: .get,
            encodableParams: []
        )
    }

}
