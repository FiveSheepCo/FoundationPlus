import Testing
import Foundation
@testable import FoundationPlus

@Test("Data is JSON", arguments: [
    "{}",
    #"{"abc":123,"def":0.1e4}"#,
    #"{"0":{"1":[1,2,3]}}"#
])
func dataIsJson(jsonString: String) {
    let data = jsonString.data(using: .utf8)!
    #expect(data.isJson())
}

@Test("Data is not JSON", arguments: [
    "{",
    #"{abc:"def"}"#,
    #"foo"#
])
func dataIsNotJson(jsonString: String) {
    let data = jsonString.data(using: .utf8)!
    #expect(!data.isJson())
}
