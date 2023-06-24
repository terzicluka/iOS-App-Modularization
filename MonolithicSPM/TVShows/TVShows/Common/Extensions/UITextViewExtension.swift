import UIKit

extension UITextField {

    func setPlaceholderColor(color: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }

}
