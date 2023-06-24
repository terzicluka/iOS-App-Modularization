import Foundation
import RxSwift
import RxCocoa
import TVShowsCore

final class HomeInteractor {
    private let service: APIService
    private let sessionManager: SessionManager

    init(service: APIService = APIService.instance, sessionManager: SessionManager = .default) {
        self.service = service
        self.sessionManager = sessionManager
    }
}

// MARK: - Extensions -

extension HomeInteractor: HomeInteractorInterface {

    func fetchShows(page: Int) -> Single<ShowsResponse> {
        return service.rx.request(
            ShowsResponse.self,
            router: HomeRouter.getShowsRouter(page: page),
            session: sessionManager.session,
            interceptor: AuthAdapter(),
            validators: [.default]
        )
    }
}

// MARK: - Paging -

extension HomeInteractor {

    typealias Container = [Show]
    typealias Page = ShowsResponse
    typealias PagingEvent = Paging.Event<Container>

    func showsPaging(loadNextPage: Driver<Void>) -> Observable<[Show]> {

        let events = Driver
            .merge(loadNextPage.mapTo(PagingEvent.nextPage), .just(PagingEvent.reload))

        func nextPage(container: Container, lastPage: Page?) -> Single<ShowsResponse> {
            var page = 1

            if let lastPage {
                page = (lastPage.meta?.pagination.page ?? 0) + 1
            }

            return fetchShows(page: page)
        }

        func accumulator(_ container: Container, _ page: Page) -> Container {
            return container + page.shows
        }

        func hasNext(container: Container, lastPage: Page) -> Bool {
            guard let responseMeta = lastPage.meta else { return false }
            return responseMeta.pagination.page < responseMeta.pagination.pages
        }

        let response = Paging
            .page(
                make: nextPage,
                startingWith: [],
                joining: accumulator,
                while: hasNext,
                on: events.asObservable()
            )

        return response.map { $0.container }
    }

}
