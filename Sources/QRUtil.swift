struct QRUtil {
    static func getLostPoint(_ qrCode: QRCodeModel) -> Int {
        let moduleCount = qrCode.getModuleCount()
        var lostPoint = 0
        for row in 0..<moduleCount {
            for col in 0..<moduleCount {
                var sameCount = 0
                let dark = qrCode.isDark(row, col)
                for r in -1...1 {
                    if row + r < 0 || moduleCount <= row + r {
                        continue
                    }
                    for c in -1...1 {
                        if col + c < 0 || moduleCount <= col + c {
                            continue
                        }
                        if r == 0 && c == 0 {
                            continue
                        }
                        if dark == qrCode.isDark(row + r, col + c) {
                            sameCount += 1
                        }
                    }
                }
                if sameCount > 5 {
                    lostPoint += (3 + sameCount - 5)
                }
            }
        }
        for row in 0..<moduleCount - 1 {
            for col in 0..<moduleCount - 1 {
                var count = 0
                if qrCode.isDark(row, col) {
                    count += 1
                }
                if qrCode.isDark(row + 1, col) {
                    count += 1
                }
                if qrCode.isDark(row, col + 1) {
                    count += 1
                }
                if qrCode.isDark(row + 1, col + 1) {
                    count += 1
                }
                if count == 0 || count == 4 {
                    lostPoint += 3
                }
            }
        }
        for row in 0..<moduleCount {
            for col in 0..<moduleCount - 6 {
                if qrCode.isDark(row, col) && !qrCode.isDark(row, col + 1) && qrCode.isDark(row, col + 2) && qrCode.isDark(row, col + 3) && qrCode.isDark(row, col + 4) && !qrCode.isDark(row, col + 5) && qrCode.isDark(row, col + 6) {
                    lostPoint += 40
                }
            }
        }
        for col in 0..<moduleCount {
            for row in 0..<moduleCount - 6 {
                if qrCode.isDark(row, col) && !qrCode.isDark(row + 1, col) && qrCode.isDark(row + 2, col) && qrCode.isDark(row + 3, col) && qrCode.isDark(row + 4, col) && !qrCode.isDark(row + 5, col) && qrCode.isDark(row + 6, col) {
                    lostPoint += 40
                }
            }
        }
        var darkCount = 0
        for col in 0..<moduleCount {
            for row in 0..<moduleCount {
                if qrCode.isDark(row, col) {
                    darkCount += 1
                }
            }
        }
        let ratio = abs(100 * darkCount / moduleCount / moduleCount - 50) / 5
        lostPoint += ratio * 10
        return lostPoint
    }
}
