import XCTest
@testable import TVShowsCore

final class TVShowsCoreTests: XCTestCase {

    func testSetCornerRadius() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.setCornerRadius(with: 50)
        XCTAssertEqual(view.layer.cornerRadius, 50, "Corner radius should be set to 50")
    }

}
