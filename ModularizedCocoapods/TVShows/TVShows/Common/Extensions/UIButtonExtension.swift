public extension UIButton {

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
                setImage(nil, for: .normal)
                return
            }

            setImage(image, for: .normal)
        }
    }
}
