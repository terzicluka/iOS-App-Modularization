import Foundation
import Alamofire

/// Base API routing class containing shared logic for all routers.
/// For each new router, for example LoginRouter, just extend this
/// class and fill necessary data
class Router: Routable {

    var baseUrl: String
    var path: String
    var method: HTTPMethod
    var headers: HTTPHeaders?
    var encodableParams: [RequestEncodableParams]

    /// Creates Routable item with given parameters.
    ///
    /// Parameters are passed as EncodableParams in a way to enable
    /// different encoding combinations, e.g.: URL query and POST body
    ///
    /// - Parameters:
    ///   - baseUrl: Base URL
    ///   - path: Path
    ///   - method: Request method, .get by default
    ///   - headers: Request headers, nil by default
    ///   - encodableParams: Request parameters with corresponding encoding
    init(
        baseUrl: String,
        path: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        encodableParams: [RequestEncodableParams]
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.headers = headers
        self.encodableParams = encodableParams
    }

    /// Creates Routable item with given parameters.
    ///
    /// - Parameters:
    ///   - baseUrl: Base URL
    ///   - path: Path
    ///   - method: Request method, .get by default
    ///   - headers: Request headers, nil by default
    ///   - parameters: Request parameters, nil by default
    ///   - encoding: Request encodings, [URLEncoding.default] by default
    init(
        baseUrl: String,
        path: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.headers = headers
        self.encodableParams = [EncodableParams(encoding: encoding, parameters: parameters)]
    }

    init<Model: Encodable>(
        baseUrl: String,
        path: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        parameters: Model? = nil,
        encoding: ParameterEncoder = URLEncodedFormParameterEncoder.default
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.headers = headers
        self.encodableParams = [EncodableParamsCoder(encoding: encoding, parameters: parameters)]
    }
}
