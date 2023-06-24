import Foundation
import RxSwift
import RxCocoa

public extension Result {

    /// Maps current result to SingleEvent type used for Single Rx trait
    var toSingleEvent: SingleEvent<Success> {
        switch self {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .failure(error)
        }
    }

    /// Maps current result to CompletableEvent type used for Completable Rx trait
    var toCompletableEvent: CompletableEvent {
        switch self {
        case .success:
            return .completed
        case .failure(let error):
            return .error(error)
        }
    }
}
