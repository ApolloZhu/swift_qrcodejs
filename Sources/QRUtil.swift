struct QRUtil {
    private static let PATTERN_POSITION_TABLE: [[Int]] = [
        [],
        [6, 18],
        [6, 22],
        [6, 26],
        [6, 30],
        [6, 34],
        [6, 22, 38],
        [6, 24, 42],
        [6, 26, 46],
        [6, 28, 50],
        [6, 30, 54],
        [6, 32, 58],
        [6, 34, 62],
        [6, 26, 46, 66],
        [6, 26, 48, 70],
        [6, 26, 50, 74],
        [6, 30, 54, 78],
        [6, 30, 56, 82],
        [6, 30, 58, 86],
        [6, 34, 62, 90],
        [6, 28, 50, 72, 94],
        [6, 26, 50, 74, 98],
        [6, 30, 54, 78, 102],
        [6, 28, 54, 80, 106],
        [6, 32, 58, 84, 110],
        [6, 30, 58, 86, 114],
        [6, 34, 62, 90, 118],
        [6, 26, 50, 74, 98, 122],
        [6, 30, 54, 78, 102, 126],
        [6, 26, 52, 78, 104, 130],
        [6, 30, 56, 82, 108, 134],
        [6, 34, 60, 86, 112, 138],
        [6, 30, 58, 86, 114, 142],
        [6, 34, 62, 90, 118, 146],
        [6, 30, 54, 78, 102, 126, 150],
        [6, 24, 50, 76, 102, 128, 154],
        [6, 28, 54, 80, 106, 132, 158],
        [6, 32, 58, 84, 110, 136, 162],
        [6, 26, 54, 82, 110, 138, 166],
        [6, 30, 58, 86, 114, 142, 170]
    ]

    private static let G15: Int = (1 << 10) | (1 << 8) | (1 << 5) | (1 << 4) | (1 << 2) | (1 << 1) | (1 << 0)
    private static let G18: Int = (1 << 12) | (1 << 11) | (1 << 10) | (1 << 9) | (1 << 8) | (1 << 5) | (1 << 2) | (1 << 0)
    private static let G15_MASK: Int = (1 << 14) | (1 << 12) | (1 << 10) | (1 << 4) | (1 << 1)


    static func getBCHTypeInfo(_ data: Int) -> Int {
        var d = data << 10
        while QRUtil.getBCHDigit(d) - QRUtil.getBCHDigit(QRUtil.G15) >= 0 {
            d ^= (QRUtil.G15 << (QRUtil.getBCHDigit(d) - QRUtil.getBCHDigit(QRUtil.G15)))
        }
        return ((data << 10) | d) ^ QRUtil.G15_MASK
    }

    static func getBCHTypeNumber(_ data: Int) -> Int {
        var d = data << 12
        while QRUtil.getBCHDigit(d) - QRUtil.getBCHDigit(QRUtil.G18) >= 0 {
            d ^= (QRUtil.G18 << (QRUtil.getBCHDigit(d) - QRUtil.getBCHDigit(QRUtil.G18)))
        }
        return (data << 12) | d
    }

    static func getBCHDigit(_ data: Int) -> Int {
        var digit = 0
        var data = UInt8(data)
        while (data != 0) {
            digit += 1
            data >>= 1
        }
        return digit
    }

    static func getPatternPosition(_ typeNumber: Int) -> [Int] {
        return QRUtil.PATTERN_POSITION_TABLE[typeNumber - 1]
    }

    static func getMask(_ maskPattern: QRMaskPattern, _ i: Int, _ j: Int) -> Bool {
        switch (maskPattern) {
        case QRMaskPattern.PATTERN000:
            return (i + j) % 2 == 0
        case QRMaskPattern.PATTERN001:
            return i % 2 == 0
        case QRMaskPattern.PATTERN010:
            return j % 3 == 0
        case QRMaskPattern.PATTERN011:
            return (i + j) % 3 == 0
        case QRMaskPattern.PATTERN100:
            return (floor(i / 2) + floor(j / 3)) % 2 == 0
        case QRMaskPattern.PATTERN101:
            return (i * j) % 2 + (i * j) % 3 == 0
        case QRMaskPattern.PATTERN110:
            return ((i * j) % 2 + (i * j) % 3) % 2 == 0
        case QRMaskPattern.PATTERN111:
            return ((i * j) % 3 + (i + j) % 2) % 2 == 0
        }
    }

    static func getErrorCorrectPolynomial(_ errorCorrectLength: Int) -> QRPolynomial {
        var a = QRPolynomial([1], 0)
        for i in 0..<errorCorrectLength {
            a = a.multiply(QRPolynomial([1, QRMath.gexp(i)], 0))
        }
        return a
    }

    static func getLengthInBits(_ mode: QRMode, _ type: Int) throws -> Int {
        if 1 <= type && type < 10 {
            switch mode {
            case QRMode.MODE_NUMBER:
                return 10
            case QRMode.MODE_ALPHA_NUM:
                return 9
            case QRMode.MODE_8BIT_BYTE,
                 QRMode.MODE_KANJI:
                return 8
            }
        } else if type < 27 {
            switch mode {
            case QRMode.MODE_NUMBER:
                return 12
            case QRMode.MODE_ALPHA_NUM:
                return 11
            case QRMode.MODE_8BIT_BYTE:
                return 16
            case QRMode.MODE_KANJI:
                return 10
            }
        } else if type < 41 {
            switch mode {
            case QRMode.MODE_NUMBER:
                return 14
            case QRMode.MODE_ALPHA_NUM:
                return 13
            case QRMode.MODE_8BIT_BYTE:
                return 16
            case QRMode.MODE_KANJI:
                return 12
            }
        } else {
            throw Error("type:\(type)")
        }
    }

    static func getLostPoint(_ qrCode: QRCodeModel) -> Int {
        var moduleCount = qrCode.getModuleCount()
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
