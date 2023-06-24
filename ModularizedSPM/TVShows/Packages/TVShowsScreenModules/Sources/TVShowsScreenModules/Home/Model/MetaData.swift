import Foundation

struct MetaData: Decodable {
    let pagination: PaginationData
}

struct PaginationData: Decodable {
    let count: Int
    let page: Int
    let items: Int
    let pages: Int
}
