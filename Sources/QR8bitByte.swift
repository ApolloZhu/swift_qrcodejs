import Foundation

struct QR8bitByte {
    let mode: QRMode = .MODE_8BIT_BYTE
    let data: String
    let parsedData: Data!

    init(_ data: String) {
        self.data = data
        self.parsedData = data.data(using: .utf8)
    }

    func getLength() -> Int {
        return parsedData.count
    }

    func write(_ buffer: inout QRBitBuffer) {
        let l: Int = parsedData.count
        for i in 0..<l {
            buffer.put(parsedData![i], 8)
        }
    }
}
