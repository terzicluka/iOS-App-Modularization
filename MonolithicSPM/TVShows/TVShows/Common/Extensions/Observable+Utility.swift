import Foundation
import RxSwift
import RxCocoa

extension ObservableType {

    /// Converts current Observable sequence to Driver, completing on error event.
    ///
    /// - Returns: Driver - completing on error event
    func asDriverOnErrorComplete() -> Driver<Element> {
        return asDriver(onErrorDriveWith: .empty())
    }

    /// Converts current Observable sequence to Signal, completing on error event.
    ///
    /// - Returns: Signal - completing on error event
    func asSignalOnErrorComplete() -> Signal<Element> {
        return self.asSignal(onErrorSignalWith: .empty())
    }

    /// Maps each sequence elements to given value.
    ///
    /// - Parameter value: Value to map
    /// - Returns: Sequence where all elements are given value.
    func mapTo<T>(_ value: T) -> Observable<T> {
        return map { _ in value }
    }

    /// Maps each sequence element to Void type.
    ///
    /// - Returns: Sequence where all elements are of Void type.
    func mapToVoid() -> Observable<Void> {
        return mapTo(())
    }

}

extension ObservableConvertibleType {

    func pipe<T>(to function: (Self) -> (T)) -> T {
        return function(self)
    }

}
