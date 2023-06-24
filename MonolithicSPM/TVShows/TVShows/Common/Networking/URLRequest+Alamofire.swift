import Foundation
import Alamofire

extension URLRequest {

    mutating func setHeader(_ header: HTTPHeader) {
        setValue(header.value, forHTTPHeaderField: header.name)
    }

    mutating func setHeader(name: String, value: String) {
        setValue(value, forHTTPHeaderField: name)
    }

    mutating func setHeaders(_ headers: [String: String]) {
        _ = headers.map {
            setHeader(name: $0, value: $1)
        }
    }
}
