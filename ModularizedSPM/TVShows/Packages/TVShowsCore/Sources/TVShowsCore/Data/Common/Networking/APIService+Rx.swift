import Foundation
import RxSwift
import Alamofire

public extension Reactive where Base: APIServiceable {

    func request<T: Decodable>(
        _: T.Type,
        keyPath: String? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        router: Routable,
        session: Session,
        interceptor: RequestInterceptor? = nil,
        validators: [DataRequestValidation]
    ) -> Single<T> {
        return Single<T>.create { [weak base] single -> Disposable in
            let request = base?.request(
                T.self,
                keyPath: keyPath,
                decoder: decoder,
                router: router,
                session: session,
                interceptor: interceptor,
                validators: validators,
                completion: {
                    single($0.toSingleEvent)
                }
            )
            return Disposables.create { request?.cancel() }
        }
    }

    func request<T: Decodable>(
        _: T.Type,
        keyPath: String? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        router: Routable,
        session: Session,
        interceptor: RequestInterceptor? = nil,
        validators: [DataRequestValidation]
    ) -> Single<(T, Dictionary<String, String>?)> {
        return Single<(T, Dictionary<String, String>?)>.create { [weak base] single -> Disposable in
            let request = base?.request(
                T.self,
                keyPath: keyPath,
                decoder: decoder,
                router: router,
                session: session,
                interceptor: interceptor,
                validators: validators,
                completion: {
                    switch $0 {
                    case .success(let data):
                        return single(.success((data, $1)))
                    case .failure(let error):
                        return single(.failure(error))
                    }
                }
            )
            return Disposables.create { request?.cancel() }
        }
    }

    func requestCompletion(
        router: Routable,
        session: Session,
        validators: [DataRequestValidation]
    ) -> Completable {
        return Completable.create { [weak base] completable -> Disposable in
            let request = base?.requestCompletion(
                router: router,
                session: session,
                validators: validators,
                completion: { completable($0.toCompletableEvent) }
            )
            return Disposables.create { request?.cancel() }
        }
    }

}
