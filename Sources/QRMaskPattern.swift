enum QRMaskPattern: Int {
    case PATTERN000 = 0
    case PATTERN001 = 1
    case PATTERN010 = 2
    case PATTERN011 = 3
    case PATTERN100 = 4
    case PATTERN101 = 5
    case PATTERN110 = 6
    case PATTERN111 = 7
}

extension QRMaskPattern {
    func getMask(_ i: Int, _ j: Int) -> Bool {
        switch (self) {
        case QRMaskPattern.PATTERN000:
            return (i + j) % 2 == 0
        case QRMaskPattern.PATTERN001:
            return i % 2 == 0
        case QRMaskPattern.PATTERN010:
            return j % 3 == 0
        case QRMaskPattern.PATTERN011:
            return (i + j) % 3 == 0
        case QRMaskPattern.PATTERN100:
            return (i / 2 + j / 3) % 2 == 0
        case QRMaskPattern.PATTERN101:
            return (i * j) % 2 + (i * j) % 3 == 0
        case QRMaskPattern.PATTERN110:
            return ((i * j) % 2 + (i * j) % 3) % 2 == 0
        case QRMaskPattern.PATTERN111:
            return ((i * j) % 3 + (i + j) % 2) % 2 == 0
        }
    }
}
