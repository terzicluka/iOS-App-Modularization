import Foundation

public enum DataRequestValidation {
    case `default`
    case acceptableStatusCodes([Int])
    case custom(DataRequestValidator)
}

public extension DataRequestValidation {

    var validator: DataRequestValidator {
        switch self {
        case .default:
            return ResponseStatusCodeValidator(acceptableStatusCodes: Array(200..<300))
        case .acceptableStatusCodes(let statusCodes):
            return ResponseStatusCodeValidator(acceptableStatusCodes: statusCodes)
        case .custom(let validator):
            return validator
        }
    }

}
