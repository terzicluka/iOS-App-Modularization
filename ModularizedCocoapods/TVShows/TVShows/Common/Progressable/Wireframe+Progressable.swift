import Foundation
import MBProgressHUD

extension BaseWireframe: Progressable {

    private var hudParentView: UIView {
        viewController.view
    }

    // MARK: - Public methods -

    // MARK: - Show/hide -

    public func showLoading() {
        showLoading(blocking: true)
    }

    public func hideLoading() {
        hideLoading(blocking: true)
    }

    // MARK: - Show/hide with blocking state -

    public func showLoading(blocking: Bool) {
        // Remove previously added so we don't need to take care about
        // multiple async calls to show loading
        MBProgressHUD.hide(for: hudParentView, animated: true)
        let hud = MBProgressHUD.showAdded(to: hudParentView, animated: true)
        hud.isUserInteractionEnabled = blocking
    }

    public func hideLoading(blocking: Bool) {
        stopRefreshingIfNeeded()
        MBProgressHUD.hide(for: hudParentView, animated: true)
    }

    // MARK: - Failure handling -

    public func showFailure(with error: Error) {
        let errorMessage = ValidationError.errorMessage(error: error)
        showFailure(with: nil, message: errorMessage)
    }

    public func showFailure(with title: String?, message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .cancel))
        viewController.present(alertView, animated: true)
    }

    // MARK: - Private methods -

    private func stopRefreshingIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            (self?.viewController as? Refreshable)?.endRefreshing()
        }
    }
}
