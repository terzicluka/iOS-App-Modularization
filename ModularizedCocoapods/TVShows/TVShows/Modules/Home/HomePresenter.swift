import Foundation
import RxSwift
import RxCocoa
import TVShowsCore

final class HomePresenter {

    // MARK: - Private properties -

    private unowned let view: HomeViewInterface
    private let interactor: HomeInteractorInterface
    private let wireframe: HomeWireframeInterface

    // MARK: - Lifecycle -

    init(
        view: HomeViewInterface,
        interactor: HomeInteractorInterface,
        wireframe: HomeWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension HomePresenter: HomePresenterInterface {

    func configure(with output: Home.ViewOutput) -> Home.ViewInput {
        let reachedBottomDriver = output.reachedBottom.asDriver(onErrorJustReturn: ())

        let shows = interactor.showsPaging(loadNextPage: reachedBottomDriver)
            .handleLoadingAndError(with: view)
            .map { $0.map { ShowTableCellItem(show: $0) as TableCellItem } }
            .asDriver(onErrorDriveWith: .empty())

        return Home.ViewInput(showCellItems: shows)
    }

}
