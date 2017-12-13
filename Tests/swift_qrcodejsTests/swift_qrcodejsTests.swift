import XCTest
@testable import swift_qrcodejs

class swift_qrcodejsTests: XCTestCase {
    func testExample() {
        print(QRCode("https://gist.github.com/agentgt/1700331")!.toString(filledWith: "MM", patchedWith: "  "))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
