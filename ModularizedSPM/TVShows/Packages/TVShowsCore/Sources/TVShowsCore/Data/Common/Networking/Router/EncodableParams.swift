import Foundation
import Alamofire

public protocol RequestEncodableParams {
    func encode(_ request: URLRequest) throws -> URLRequest
}

/// Request params from encodable model with associated encoding. Used in conjuction with
/// networking router
public struct EncodableParamsCoder<Model: Encodable>: RequestEncodableParams {

    // MARK: - Private properties -

    private let encoding: ParameterEncoder
    private let parameters: Model

    // MARK: - Init -

    public init(
        encoding: ParameterEncoder = URLEncodedFormParameterEncoder.default,
        parameters: Model
    ) {
        self.encoding = encoding
        self.parameters = parameters
    }

    public func encode(_ request: URLRequest) throws -> URLRequest {
        return try encoding.encode(parameters, into: request)
    }
}

/// Request params with associated encoding. Used in conjuction with
/// networking router
public struct EncodableParams: RequestEncodableParams {

    // MARK: - Private properties -

    private let encoding: ParameterEncoding
    private let parameters: Parameters?

    // MARK: - Init -

    public init(
        encoding: ParameterEncoding = URLEncoding.default,
        parameters: Parameters?
    ) {
        self.encoding = encoding
        self.parameters = parameters
    }

    public func encode(_ request: URLRequest) throws -> URLRequest {
        return try encoding.encode(request, with: parameters)
    }

}
