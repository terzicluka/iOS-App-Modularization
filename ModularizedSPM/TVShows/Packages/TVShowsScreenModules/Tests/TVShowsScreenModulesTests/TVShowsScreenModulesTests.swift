import XCTest
@testable import TVShowsScreenModules

final class TVShowsScreenModulesTests: XCTestCase {

    func testHomeTitle() {
        let viewController = HomeViewController()
        XCTAssertEqual(viewController.homeTitle, "Shows", "Home title should be set to 'Shows'")
    }
}
