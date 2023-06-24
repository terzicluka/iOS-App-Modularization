import UIKit

public protocol Refreshable {
    var refreshControl: UIRefreshControl { get }
}

public extension Refreshable {

    func endRefreshing() {
        // Check if refresh control is refreshing before calling endRefreshing,
        // otherwise it will result in wierd glitch while scrolling and reloading
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

}
