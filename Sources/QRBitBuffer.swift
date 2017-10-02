import Foundation

struct QRBitBuffer {
    var buffer = [UInt8]()
    var length = 0
    
    func get(_ index: Int) -> Bool {
        let bufIndex = index / 8
        return ((buffer[bufIndex] >> (7 - index % 8)) & 1) == 1
    }
    
    mutating func put(_ num: UInt8, _ length: Int) {
        for i in 0..<length {
            putBit(((num >> (length - i - 1)) & 1) == 1)
        }
    }
    
    func getLengthInBits() -> Int {
        return length
    }
    
    mutating func putBit(_ bit: Bool) {
        let bufIndex = length / 8
        if buffer.count <= bufIndex {
            buffer.append(0)
        }
        if bit {
            buffer[bufIndex] |= (UInt8(0x80) >> UInt8(length % 8))
        }
        length += 1
    }
}
