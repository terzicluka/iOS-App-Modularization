import UIKit
import TVShowsCore

final class ShowTableViewCell: UITableViewCell {

    // MARK: - Constants -

    private enum Constants {
        static let cornerRadius = CGFloat(4)
    }

    // MARK: - IBOutlets -

    @IBOutlet fileprivate weak var showTitleLabel: UILabel!
    @IBOutlet fileprivate weak var showImage: UIImageView!

    // MARK: - Lifecycle -

    override func prepareForReuse() {
        super.prepareForReuse()
        showImage.kf.cancelDownloadTask()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        showImage.layer.cornerRadius = Constants.cornerRadius
        showImage.clipsToBounds = true
    }

}

struct ShowTableCellItem: TableCellItem {

    private enum Constants {
        static let placeholderName = "ic-show-placeholder-vertical"
    }

    let show: Show

    func cell(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ShowTableViewCell.self, for: indexPath)
        cell.showTitleLabel.text = show.title
        cell.showImage.setImage(withUrl: show.imageUrl, placeholder: Constants.placeholderName)
        return cell
    }
}
