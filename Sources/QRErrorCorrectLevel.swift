public enum QRErrorCorrectLevel: Int {
    /// Error resilience level: 7%
    case L = 1
    /// Error resilience level: 15%
    case M = 0
    /// Error resilience level: 25%
    case Q = 3
    /// Error resilience level: 30%
    case H = 2
}

extension QRErrorCorrectLevel {
    public var ciQRCodeGeneratorInputCorrectionLevel: String {
        switch self {
        case .L: return "l"
        case .M: return "m"
        case .Q: return "q"
        case .H: return "h"
        }
    }
}
