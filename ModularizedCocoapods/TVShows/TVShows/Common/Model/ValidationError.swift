import Foundation

public enum ValidationError: Error {
    case error(message: String)
    case unaccaptableStatusCode(Int)
}

public extension ValidationError {

    static func errorMessage(error: Error) -> String {
        let underlyingError = error.asAFError(orFailWith: Constants.Messages.genericError).underlyingError
        let validationError = underlyingError as? ValidationError
        switch validationError {
        case .error(let message):
            return message
        case .unaccaptableStatusCode(let errorCode):
            return Constants.Messages.statusCodeError + errorCode.description
        default:
            return Constants.Messages.genericError
        }
    }

}
