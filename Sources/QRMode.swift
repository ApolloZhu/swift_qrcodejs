enum QRMode: UInt8 { // OptionSet
    case MODE_NUMBER = 0b0001 // 1 << 0
    case MODE_ALPHA_NUM = 0b0010 // 1 << 1
    case MODE_8BIT_BYTE = 0b0100 //1 << 2
    case MODE_KANJI = 0b1000 // 1 << 3
}

extension QRMode {
    func getLengthInBits(_ type: Int) throws -> Int {
        if 1 <= type && type < 10 {
            switch self {
            case QRMode.MODE_NUMBER:
                return 10
            case QRMode.MODE_ALPHA_NUM:
                return 9
            case QRMode.MODE_8BIT_BYTE,
                 QRMode.MODE_KANJI:
                return 8
            }
        } else if type < 27 {
            switch self {
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
            switch self {
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
}
