struct BCHUtil {
    private static let G15      =     0b10100110111
    private static let G18      =   0b1111100100101
    private static let G15_MASK = 0b101010000010010
    
    static func getBCHTypeInfo(_ data: Int) -> Int {
        var d = data << 10
        while getBCHDigit(d) - getBCHDigit(G15) >= 0 {
            d ^= (G15 << (getBCHDigit(d) - getBCHDigit(G15)))
        }
        return ((data << 10) | d) ^ G15_MASK
    }
    
    static func getBCHTypeNumber(_ data: Int) -> Int {
        var d = data << 12
        while getBCHDigit(d) - getBCHDigit(G18) >= 0 {
            d ^= (G18 << (getBCHDigit(d) - getBCHDigit(G18)))
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
}
