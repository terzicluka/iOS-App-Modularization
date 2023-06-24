import Foundation

final class AuthInfoManager {
    static let instance = AuthInfoManager()
    var authInfo: AuthInfo?

    private init() { }
}

struct AuthInfo: Codable {
    private let accessToken: String
    private let client: String
    private let tokenType: String
    private let expiry: String
    private let uid: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access-token"
        case client
        case tokenType = "token-type"
        case expiry
        case uid
    }

    init(from headers: [String: String]) throws {
        let data = try JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted)
        self = try JSONDecoder().decode(Self.self, from: data)
    }

    var headers: [String: String] {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            return jsonObject as? [String: String] ?? [:]
        } catch {
            return [:]
        }
    }
}
