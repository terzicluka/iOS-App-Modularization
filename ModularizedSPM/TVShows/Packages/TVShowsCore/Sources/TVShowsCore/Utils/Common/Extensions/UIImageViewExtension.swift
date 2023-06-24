import Kingfisher
import UIKit

public extension UIImageView {

    private enum Constants {
        static var imageKey = "TVShowsResourceBundleImage"
    }

    @IBInspectable var tvShowsImageName: String? {
        get {
            objc_getAssociatedObject(self, &Constants.imageKey) as? String
        }

        set(imageName) {
            objc_setAssociatedObject(self, &Constants.imageKey, imageName, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            guard let imageName = imageName,
                  let image = UIImage(named: imageName, in: .main, compatibleWith: nil)
            else {
                self.image = nil
                return
            }

            self.image = image
        }
    }
}

public extension UIImageView {

    func setImage(withUrl image: URL?, placeholder: String) {
        let placeholderImage = UIImage(named: placeholder)
        let options: KingfisherOptionsInfo = [.transition(.fade(0.3))]
        kf.setImage(with: image, placeholder: placeholderImage, options: options)
    }

}
