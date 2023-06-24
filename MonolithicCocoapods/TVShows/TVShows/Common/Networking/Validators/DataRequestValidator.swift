import Foundation

protocol DataRequestValidator {

    func validate(request: URLRequest?, response: HTTPURLResponse, data: Data?) throws

}
