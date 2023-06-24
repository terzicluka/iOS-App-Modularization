import Foundation

struct APIError: Decodable {
    let errors: [String]
}
