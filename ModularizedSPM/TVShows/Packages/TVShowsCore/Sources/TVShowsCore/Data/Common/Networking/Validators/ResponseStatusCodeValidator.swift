import Foundation

public struct ResponseStatusCodeValidator {

    private let acceptableStatusCodes: [Int]

    public init(acceptableStatusCodes: [Int]) {
        self.acceptableStatusCodes = acceptableStatusCodes
    }

}

// MARK: - Extensions -

extension ResponseStatusCodeValidator: DataRequestValidator {

    public func validate(request: URLRequest?, response: HTTPURLResponse, data: Data?) throws {
        guard !acceptableStatusCodes.contains(response.statusCode) else { return }
        throw ValidationError.unaccaptableStatusCode(response.statusCode)
    }

}
