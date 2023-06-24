import Foundation

struct UserResponse: Decodable {
    let user: User
}

struct User: Decodable {
    let id: String
    let email: String
    let imageUrl: URL?

    enum CodingKeys: String, CodingKey {
        case id, email
        case imageUrl = "image_url"
    }
}
