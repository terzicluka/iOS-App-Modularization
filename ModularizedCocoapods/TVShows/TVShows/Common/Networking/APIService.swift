import Foundation
import Alamofire

/// Base protocol for API networking communication.
public protocol APIServiceable: AnyObject {

    @discardableResult
    func request<T: Decodable>(
        _: T.Type,
        keyPath: String?,
        decoder: JSONDecoder,
        router: Routable,
        session: Session,
        interceptor: RequestInterceptor?,
        validators: [DataRequestValidation],
        completion: @escaping (AFResult<T>) -> Void
    ) -> DataRequest

    @discardableResult
    func request<T: Decodable>(
        _: T.Type,
        keyPath: String?,
        decoder: JSONDecoder,
        router: Routable,
        session: Session,
        interceptor: RequestInterceptor?,
        validators: [DataRequestValidation],
        completion: @escaping (AFResult<T>, Dictionary<String, String>?) -> Void
    ) -> DataRequest

    @discardableResult
    func requestCompletion(
        router: Routable,
        session: Session,
        validators: [DataRequestValidation],
        completion: @escaping (AFResult<Void>) -> Void
    ) -> DataRequest

}

public extension APIServiceable {

    /// Creates data request from router and validates it
    /// - Parameters:
    ///   - router: Routable item
    ///   - session: Current session
    func prepareRequest(
        for router: Routable,
        session: Session,
        interceptor: RequestInterceptor? = nil,
        validators: [DataRequestValidation]
    ) -> DataRequest {
        session
            .request(router, interceptor: interceptor)
            .validate { request, response, data in
                do {
                    try validators
                        .map(\.validator)
                        .forEach {
                            try $0.validate(request: request, response: response, data: data)
                        }
                } catch {
                    return .failure(error)
                }

                return .success(())
            }
    }

}

/// Base API service class containing shared logic for all API calls
public class APIService: APIServiceable {

    public static var instance = APIService()

    @discardableResult
    public func request<T: Decodable>(
        _: T.Type,
        keyPath: String? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        router: Routable,
        session: Session,
        interceptor: RequestInterceptor? = nil,
        validators: [DataRequestValidation],
        completion: @escaping (AFResult<T>) -> Void
    ) -> DataRequest {
        prepareRequest(
            for: router,
            session: session,
            interceptor: interceptor,
            validators: validators
        ).responseDecodable(
            keyPath: keyPath,
            decoder: decoder,
            completionHandler: { completion($0.result) }
        )
    }

    // add headers to return type
    @discardableResult
    public func request<T: Decodable>(
        _: T.Type,
        keyPath: String? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        router: Routable,
        session: Session,
        interceptor: RequestInterceptor? = nil,
        validators: [DataRequestValidation],
        completion: @escaping (AFResult<T>, Dictionary<String, String>?) -> Void
    ) -> DataRequest {
        prepareRequest(
            for: router,
            session: session,
            interceptor: interceptor,
            validators: validators
        ).responseDecodable(
            keyPath: keyPath,
            decoder: decoder,
            completionHandler: { completion($0.result, $0.response?.headers.dictionary) }
        )
    }

    @discardableResult
    public func requestCompletion(
        router: Routable,
        session: Session,
        validators: [DataRequestValidation],
        completion: @escaping (AFResult<Void>) -> Void
    ) -> DataRequest {
        prepareRequest(
            for: router,
            session: session,
            validators: validators
        ).response { completion($0.result.mapToVoid) }
    }

}

import RxSwift

extension APIService: ReactiveCompatible { }
