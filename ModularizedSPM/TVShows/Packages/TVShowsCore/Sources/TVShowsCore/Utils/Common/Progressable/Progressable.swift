import Foundation

public protocol Progressable: AnyObject {
    func showLoading()
    func hideLoading()

    func showLoading(blocking: Bool)
    func hideLoading(blocking: Bool)

    func showFailure(with error: Error)
    func showFailure(with title: String?, message: String?)
}

public extension Progressable {
    func showLoading(blocking: Bool) { }
    func hideLoading(blocking: Bool) { }

    func showFailure(with error: Error) { }
    func showFailure(with title: String?, message: String?) { }
}
