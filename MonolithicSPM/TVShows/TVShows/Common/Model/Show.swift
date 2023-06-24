import Foundation

struct ShowsResponse: Decodable {
    let shows: [Show]
    let meta: MetaData?
}

struct Show: Decodable {
    let id: String
    let averageRating: Int?
    let description: String?
    let imageUrl: URL?
    let numberOfReviews: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case id, description, title
        case imageUrl = "image_url"
        case averageRating = "average_rating"
        case numberOfReviews = "no_of_reviews"
    }
}
