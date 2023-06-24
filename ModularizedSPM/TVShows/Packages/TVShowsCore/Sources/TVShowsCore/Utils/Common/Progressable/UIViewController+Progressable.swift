import UIKit
import MBProgressHUD

extension UIViewController: Progressable {

    // MARK: - Show/hide loading

    public func showLoading() {
        showLoading(blocking: true)
    }

    public func hideLoading() {
        hideLoading(blocking: true)
    }

    public func showLoading(blocking: Bool) {
        // Remove previously added so we don't need to take care about
        // multiple async calls to show loading
        MBProgressHUD.hide(for: view, animated: true)
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.isUserInteractionEnabled = blocking
    }

    public func hideLoading(blocking: Bool) {
        stopRefreshingIfNeeded()
        MBProgressHUD.hide(for: view, animated: true)
    }

}

// MARK: - Failure handling

public extension UIViewController {

    func showFailure(with error: Error) {
        let errorMessage = ValidationError.errorMessage(error: error)
        showFailure(with: nil, message: errorMessage)
    }

    func showFailure(with title: String?, message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertView, animated: true)
    }

}

// MARK: - Private methods

extension UIViewController {

    private func stopRefreshingIfNeeded() {
        (self as? Refreshable)?.endRefreshing()
    }

}
