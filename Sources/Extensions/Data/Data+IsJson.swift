import Foundation

extension Data {

    /// Check if the data is JSON.
    ///
    /// - Parameter options: The JSON reading options.
    @inlinable
    func isJson(options: JSONSerialization.ReadingOptions = []) -> Bool {
        (try? JSONSerialization.jsonObject(with: self, options: options)) != nil
    }
}
