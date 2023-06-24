import Foundation

public struct APIError: Decodable {
    public let errors: [String]
}
