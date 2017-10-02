enum QRMode: UInt8 { // OptionSet
    case MODE_NUMBER = 0b0001 // 1 << 0
    case MODE_ALPHA_NUM = 0b0010 // 1 << 1
    case MODE_8BIT_BYTE = 0b0100 //1 << 2
    case MODE_KANJI = 0b1000 // 1 << 3
}
