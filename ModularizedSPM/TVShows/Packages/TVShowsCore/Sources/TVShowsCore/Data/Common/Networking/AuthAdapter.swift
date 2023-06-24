import Foundation
import Alamofire

/// Adapter used for token-based authentication
public struct AuthAdapter: RequestInterceptor {

    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        let authInfo = AuthInfoManager.instance.authInfo?.headers

        var urlRequest = urlRequest

        if let authInfo {
            urlRequest.setHeaders(authInfo)
        }

        completion(.success(urlRequest))
    }

    public init() { }
}
