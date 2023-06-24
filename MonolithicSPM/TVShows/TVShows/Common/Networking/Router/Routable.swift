import Foundation
import Alamofire

/// Defines all data needed for making an API request
protocol Routable: URLRequestConvertible {

    /// Base API url, e.g.:  https://www.google.com
    var baseUrl: String { get }

    /// Path to requested resource, e.g.: /text
    var path: String { get }

    /// Request method
    var method: HTTPMethod { get }

    /// Request headers
    var headers: HTTPHeaders? { get }

    /// Request parameters with associated encoding
    var encodableParams: [RequestEncodableParams] { get }
}

extension Routable {

    func asURLRequest() throws -> URLRequest {
        let url = try pathUrl()
        var request = try URLRequest(url: url, method: method, headers: headers)
        try encodableParams.forEach { request = try $0.encode(request) }
        return request
    }

}

private extension Routable {

    func pathUrl() throws -> URL {
        /// Fully specified path wih base URL
        if path.starts(with: "http") {
            return try path.asURL()
        }
        /// If not, append path to current base URL
        return try baseUrl
            .asURL()
            .appendingPathComponent(path)
    }

}
