import XCTest

@testable import TVShowsScreenModules

final class HomeTest: XCTestCase {

    func testHomeTitle() {
        let viewController = HomeViewController()
        XCTAssertEqual(viewController.homeTitle, "Shows", "Home title should be set to 'Shows'")
    }

}
