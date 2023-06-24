import UIKit

/// Used in conjuction with TableDataSourceDelegate to provide a way
/// to control table view reloading behavior
protocol TableViewReloader {

    /// Called when new data arrives and reload is necessary
    ///
    /// - Parameters:
    ///   - tableView: Current table view
    ///   - oldSections: Previous sections/items
    ///   - newSections: New sections/items
    func reload(
        _ tableView: UITableView,
        oldSections: [TableSectionItem]?,
        newSections: [TableSectionItem]?
    )

}

/// Reloads table view data simply calling table view reloadData method
struct DefaultTableViewReloader: TableViewReloader {

    init() { }

    func reload(_ tableView: UITableView, oldSections: [TableSectionItem]?, newSections: [TableSectionItem]?) {
        tableView.reloadData()
    }

}
