struct QRMath {
    static func glog(_ n: Int) throws -> Int {
        if (n < 1) { throw Error("glog(\(n))") }
        return QRMath.instance.LOG_TABLE[n]
    }

    static func gexp(_ n: Int) -> Int {
        var n = n
        while n < 0 { n += 255 }
        while (n >= 256) { n -= 255 }
        return QRMath.instance.EXP_TABLE[n]
    }

    private var EXP_TABLE: [Int]
    private var LOG_TABLE: [Int]

    private static let instance = QRMath()
    private init() {
        EXP_TABLE = [Int](repeating: 0, count: 256)
        LOG_TABLE = [Int](repeating: 0, count: 256)
        for i in 0..<8 {
            EXP_TABLE[i] = 1 << i
        }
        for i in 8..<256 {
            EXP_TABLE[i] = EXP_TABLE[i - 4] ^ EXP_TABLE[i - 5] ^ EXP_TABLE[i - 6] ^ EXP_TABLE[i - 8]
        }
        for i in 0..<255 {
            LOG_TABLE[EXP_TABLE[i]] = i
        }
    }
}
