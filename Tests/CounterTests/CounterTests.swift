import XCTest
@testable import Counter

final class CounterTests: XCTestCase {

    // Todo: Needs tests!

    static var allTests = [
        ("testExample", testExample),
    ]

    func testExample() {
        XCTAssertEqual(Counter().text, "Hello, World!")
    }

}
