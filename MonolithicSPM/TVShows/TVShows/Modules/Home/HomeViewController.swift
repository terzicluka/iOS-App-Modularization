import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    private enum Constants {
        static let offset = CGFloat(10)
    }

    // MARK: - Public properties -

    var presenter: HomePresenterInterface!

    // MARK: - IBOutlets -

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Private properties -

    private lazy var tableDataSource: TableDataSourceDelegate = {
        return TableDataSourceDelegate(tableView: tableView)
    }()

    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

// MARK: - Extensions -

extension HomeViewController: HomeViewInterface {
}

private extension HomeViewController {

    func setupView() {
        let reachedBottom = tableView.rx.reachedBottomOnce(offset: Constants.offset)
        let output = Home.ViewOutput(reachedBottom: reachedBottom.asSignal(onErrorSignalWith: .empty()))
        handle(input: presenter.configure(with: output))
    }

}

// MARK: - Handle methods -

private extension HomeViewController {

    func handle(input: Home.ViewInput) {
        input
            .showCellItems
            .drive(tableDataSource.rx.items)
            .disposed(by: disposeBag)
    }

}
