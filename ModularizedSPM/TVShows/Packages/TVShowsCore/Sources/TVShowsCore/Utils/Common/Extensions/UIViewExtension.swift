import UIKit

public extension UIView {

    func setCornerRadius(with percentage: Float) {
        layer.cornerRadius = self.bounds.height * CGFloat(percentage / 100)
    }

}
