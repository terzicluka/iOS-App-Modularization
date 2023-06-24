import Foundation

public struct LoginStatusValidator: DataRequestValidator {

    private enum Constants {
        enum Messages {
            static let emailError = "Login failed. Please check your email and password and try again."
        }
    }

    public func validate(request: URLRequest?, response: HTTPURLResponse, data: Data?) throws {
        guard
            let data,
            (response.statusCode == 401 || response.statusCode == 422)
        else { return }
        let error = try JSONDecoder().decode(APIError.self, from: data)
        let message = error.errors.first ?? Constants.Messages.emailError
        throw ValidationError.error(message: message)
    }

    public init() { }

}
