import XCTest
@testable import BTKit

final class BTKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BTKit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}