import XCTest
@testable import swift_qrcodejs

class swift_qrcodejsTests: XCTestCase {
    func testExample() {
        print(QRCode("https://gist.github.com/agentgt/1700331")!.toString(filledWith: "MM", patchedWith: "  "))
    }

    func testAWB() {
        print(QRCode("https://passport.bilibili.com/qrcode/h5/login?oauthKey=2f3ab118e214e7ad69683df50918a481", size: CGSize(width: 136, height:151), colorDark: 0xFFFFFF, colorLight: 0)!.toString(filledWith: "MM", patchedWith: "  "))
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
