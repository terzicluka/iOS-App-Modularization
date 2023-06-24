import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType where SharingStrategy == DriverSharingStrategy {

    /// Creates new subscription and sends elements to `PublishRelay`.
    ///
    /// - Parameter relay: PublishRelay instance
    /// - Returns: Disposable for current subscription
    func drive(_ relay: PublishRelay<Element>) -> Disposable {
        return drive(onNext: { element in relay.accept(element) })
    }

    /// Safely unwraps optional value from chain
    func compactMap<T>() -> Driver<T> where Element == T? {
        return compactMap { $0 }
    }

    /// Returns a sequence by the source observable sequence
    /// shifted forward in time by a specified delay.
    /// Error events from the source observable sequence are not delayed.
    ///
    /// - Parameter dueTime: Delay time interval (seconds)
    /// - Returns: Delayed sequnece
    func delay(dueTime: RxTimeInterval) -> Driver<Element> {
        return self
            .asObservable()
            .delay(dueTime, scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: .empty())
    }

    /// Returns a specified number of contiguous elements from the start of an observable sequence.
    ///
    /// - Parameter count: The number of elements to return.
    /// - Returns: A sequence that contains the specified number of elements from the start of the input sequence.
    func take(_ count: Int) -> Driver<Element> {
        return self
            .asObservable()
            .take(count)
            .asDriver(onErrorDriveWith: .empty())
    }

    /// Maps each sequence elements to given value.
    ///
    /// - Parameter value: Value to map
    /// - Returns: Sequence where all elements are given value.
    func mapTo<T>(_ value: T) -> Driver<T> {
        return map { _ in value }
    }

    /// Maps each sequence element to Void type.
    ///
    /// - Returns: Sequence where all elements are of Void type.
    func mapToVoid() -> Driver<Void> {
        return mapTo(())
    }

}
