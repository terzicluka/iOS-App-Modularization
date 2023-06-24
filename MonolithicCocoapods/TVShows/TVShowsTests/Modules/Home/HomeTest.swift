import XCTest

@testable import TVShows

final class HomeTest: XCTestCase {

    func testHomeTitle() {
        let viewController = HomeViewController()
        XCTAssertEqual(viewController.homeTitle, "Shows", "Home title should be set to 'Shows'")
    }

}
