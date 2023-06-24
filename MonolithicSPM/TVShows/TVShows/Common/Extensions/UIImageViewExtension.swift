import Kingfisher
import UIKit

extension UIImageView {

    func setImage(withUrl image: URL?, placeholder: String) {
        let placeholderImage = UIImage(named: placeholder)
        let options: KingfisherOptionsInfo = [.transition(.fade(0.3))]
        kf.setImage(with: image, placeholder: placeholderImage, options: options)
    }

}
