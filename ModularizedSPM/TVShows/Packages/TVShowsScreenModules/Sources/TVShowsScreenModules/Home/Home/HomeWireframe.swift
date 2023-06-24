import UIKit
import TVShowsCore

final class HomeWireframe: BaseWireframe<HomeViewController> {

    // MARK: - Constants -

    private enum Constants {
        enum Storyboard {
            static let home = "Home"
        }
    }

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: Constants.Storyboard.home, bundle: Bundle.module)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: HomeViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = HomeInteractor()
        let presenter = HomePresenter(
            view: moduleViewController,
            interactor: interactor,
            wireframe: self
        )
        moduleViewController.presenter = presenter
    }

}

extension HomeWireframe: HomeWireframeInterface {
}
