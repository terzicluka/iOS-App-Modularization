import Foundation

public extension Result {

    /// Maps Result Success type to Void
    var mapToVoid: Result<Void, Failure> {
        return self.map { _ in () }
    }
}
