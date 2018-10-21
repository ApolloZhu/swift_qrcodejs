import swift_qrcodejs
import Foundation
let args = ProcessInfo.processInfo.arguments
let link: String
if args.count > 1 {
    link = args.last!
} else {
    var input: String?
    print("Generate QRCode for", terminator: ": ")
    repeat { input = readLine() } while (input == nil)
    link = input!
}
guard let qr = QRCode(link) else { fatalError("Failed to generate for \(link)") }
let inverse = "\u{1B}[7m  ", normal = "\u{1B}[0m  "
print(qr.toString(filledWith: inverse, patchedWith: normal))
