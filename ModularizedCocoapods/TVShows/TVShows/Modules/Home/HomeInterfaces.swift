import UIKit
import RxSwift
import RxCocoa
import TVShowsCore

protocol HomeWireframeInterface: WireframeInterface {
}

protocol HomeViewInterface: ViewInterface {
}

protocol HomePresenterInterface: PresenterInterface {
    func configure(with output: Home.ViewOutput) -> Home.ViewInput
}

protocol HomeInteractorInterface: InteractorInterface {
    func fetchShows(page: Int) -> Single<ShowsResponse>
    func showsPaging(loadNextPage: Driver<Void>) -> Observable<[Show]> 
}

enum Home {

    struct ViewOutput {
        let reachedBottom: Signal<Void>
    }

    struct ViewInput {
        let showCellItems: Driver<[TableCellItem]>
    }
}
