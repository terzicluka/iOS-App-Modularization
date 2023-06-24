public protocol ItemConfigurable {
    associatedtype ConfigurationItem

    /// Configures the implementee with the recieved item
    /// - Parameter item: item containing configuration data
    func configure(with item: ConfigurationItem)
}
