struct QRCodeModel {
    let typeNumber: Int
    let errorCorrectLevel: QRErrorCorrectLevel
    var modules: [[Bool?]]! = nil
    var moduleCount = 0
    var dataCache: [Int]! = nil
    var dataList: [QR8bitByte] = []
    init(_ typeNumber: Int, _ errorCorrectLevel: QRErrorCorrectLevel) {
        self.typeNumber = typeNumber
        self.errorCorrectLevel = errorCorrectLevel
    }
    mutating func addData(_ data: String) {
        let newData = QR8bitByte(data)
        dataList.append(newData)
        dataCache = nil
    }
    func isDark(_ row: Int, _ col: Int) throws -> Bool! {
        if (row < 0 || self.moduleCount <= row || col < 0 || self.moduleCount <= col) {
            throw Error("\(row),\(col)")
        }
        return modules[row][col]
    }

    func getModuleCount() -> Int {
        return moduleCount
    }

    mutating func make() {
        makeImpl(false, getBestMaskPattern())
    }

    mutating func makeImpl(_ test: Bool, _ maskPattern: QRMaskPattern) {
        moduleCount = typeNumber * 4 + 17
        modules = [[Bool?]](repeating:
            [Bool?](repeating: nil, count: moduleCount),
            count: moduleCount)

        setupPositionProbePattern(0, 0)
        setupPositionProbePattern(moduleCount - 7, 0)
        setupPositionProbePattern(0, moduleCount - 7)
        setupPositionAdjustPattern()
        setupTimingPattern()
        setupTypeInfo(test, maskPattern.rawValue)
        if (typeNumber >= 7) {
            setupTypeNumber(test)
        }
        if (dataCache == nil) {
            dataCache = try! QRCodeModel.createData(typeNumber, errorCorrectLevel, dataList)
        }
        mapData(dataCache, maskPattern)
    }

    mutating func setupPositionProbePattern(_ row: Int, _ col: Int) {
        for r in -1...7 {
            if (row + r <= -1 || moduleCount <= row + r) {
                continue
            }
            for c in -1...7 {
                if (col + c <= -1 || moduleCount <= col + c) {
                    continue
                }
                if ((0 <= r && r <= 6 && (c == 0 || c == 6)) || (0 <= c && c <= 6 && (r == 0 || r == 6)) || (2 <= r && r <= 4 && 2 <= c && c <= 4)) {
                    modules[row + r][col + c] = true
                } else {
                    modules[row + r][col + c] = false
                }
            }
        }
    }

    mutating func getBestMaskPattern() -> QRMaskPattern! {
        var minLostPoint = 0
        var pattern = 0
        for i in 0..<8 {
            makeImpl(true, QRMaskPattern(rawValue: i)!)
            let lostPoint = QRUtil.getLostPoint(self)
            if (i == 0 || minLostPoint > lostPoint) {
                minLostPoint = lostPoint
                pattern = i
            }
        }
        return QRMaskPattern(rawValue: pattern)
    }

    mutating func setupTimingPattern() {
        for r in 8..<moduleCount - 8 {
            if (modules[r][6] != nil) {
                continue
            }
            modules[r][6] = (r % 2 == 0)
        }
        for c in 8..<moduleCount - 8 {
            if (modules[6][c] != nil) {
                continue
            }
            modules[6][c] = (c % 2 == 0)
        }
    }

    mutating func setupPositionAdjustPattern() {
        let pos = QRUtil.getPatternPosition(typeNumber)
        for i in 0..<pos.count {
            for j in 0..<pos.count {
                let row = pos[i]
                let col = pos[j]
                if (modules[row][col] != nil) {
                    continue
                }
                for r in -2...2 {
                    for c in -2...2 {
                        if (r == -2 || r == 2 || c == -2 || c == 2 || (r == 0 && c == 0)) {
                            modules[row + r][col + c] = true
                        } else {
                            modules[row + r][col + c] = false
                        }
                    }
                }
            }
        }
    }

    mutating func setupTypeNumber(_ test: Bool) {
        let bits: Int = QRUtil.getBCHTypeNumber(self.typeNumber)
        // FIXME: Optimize Loop
        for i in 0..<18 {
            let mod = (!test && ((bits >> i) & 1) == 1)
            modules[i / 3][i % 3 + moduleCount - 8 - 3] = mod
        }
        for i in 0..<18 {
            let mod = (!test && ((bits >> i) & 1) == 1)
            modules[i % 3 + moduleCount - 8 - 3][i / 3] = mod
        }
    }

    mutating func setupTypeInfo(_ test: Bool, _ maskPattern: Int) {
        let data = (errorCorrectLevel.rawValue << 3) | maskPattern
        let bits: Int = QRUtil.getBCHTypeInfo(data)
        // FIXME: Optimize Loop
        for i in 0..<15 {
            let mod = !test && ((bits >> i) & 1) == 1
            if (i < 6) {
                modules[i][8] = mod
            } else if (i < 8) {
                modules[i + 1][8] = mod
            } else {
                modules[moduleCount - 15 + i][8] = mod
            }
        }
        for i in 0..<15 {
            let mod = !test && ((bits >> i) & 1) == 1
            if (i < 8) {
                modules[8][moduleCount - i - 1] = mod
            } else if (i < 9) {
                modules[8][15 - i - 1 + 1] = mod
            } else {
                modules[8][15 - i - 1] = mod
            }
        }
        modules[moduleCount - 8][8] = !test
    }

    mutating func mapData(_ data: [Int], _ maskPattern: QRMaskPattern) {
        var inc = -1
        var row = moduleCount - 1
        var bitIndex = 7
        var byteIndex = 0

        for var col in stride(from: moduleCount - 1, to: 0, by: -2) {
            if (col == 6) { col -= 1 }
            while (true) {
                for c in 0..<2 {
                    if modules[row][col - c] == nil {
                        var dark = false
                        if byteIndex < data.count {
                            dark = ((UInt8(data[byteIndex]) >> bitIndex) & 1) == 1
                        }
                        let mask = QRUtil.getMask(maskPattern, row, col - c)
                        if mask {
                            dark = !dark
                        }
                        modules[row][col - c] = dark
                        bitIndex -= 1
                        if bitIndex == -1 {
                            byteIndex += 1
                            bitIndex = 7
                        }
                    }
                }
                row += inc
                if row < 0 || moduleCount <= row {
                    row -= inc
                    inc = -inc
                    break
                }
            }
        }
    }

    static let PAD0: UInt8 = 0xEC
    static let PAD1: UInt8 = 0x11


    static func createData(_ typeNumber: Int, _ errorCorrectLevel: QRErrorCorrectLevel, _ dataList: [QR8bitByte]) throws -> [Int] {
        var rsBlocks = QRRSBlock.getRSBlocks(typeNumber, errorCorrectLevel)
        var buffer = QRBitBuffer()
        for i in 0..<dataList.count {
            let data = dataList[i]
            buffer.put(data.mode.rawValue, 4)
            buffer.put(UInt8(data.getLength()),
                       try! QRUtil.getLengthInBits(data.mode, typeNumber))
            data.write(&buffer)
        }
        var totalDataCount = 0
        for i in 0..<rsBlocks.count {
            totalDataCount += rsBlocks[i].dataCount
        }
        if (buffer.getLengthInBits() > totalDataCount * 8) {
            throw Error("code length overflow. (\(buffer.getLengthInBits())>\(totalDataCount * 8))")
        }
        if buffer.getLengthInBits() + 4 <= totalDataCount * 8 {
            buffer.put(0, 4)
        }
        while buffer.getLengthInBits() % 8 != 0 {
            buffer.putBit(false)
        }
        while (true) {
            if buffer.getLengthInBits() >= totalDataCount * 8 {
                break
            }
            buffer.put(QRCodeModel.PAD0, 8)
            if buffer.getLengthInBits() >= totalDataCount * 8 {
                break
            }
            buffer.put(QRCodeModel.PAD1, 8)
        }
        return QRCodeModel.createBytes(buffer, rsBlocks)
    }

    static func createBytes(_ buffer: QRBitBuffer, _ rsBlocks: [QRRSBlock]) -> [Int] {
        var offset = 0
        var maxDcCount = 0
        var maxEcCount = 0
        var dcdata = [[Int]!](repeating: nil, count: rsBlocks.count)
        var ecdata = [[Int]!](repeating: nil, count: rsBlocks.count)
        for r in 0..<rsBlocks.count {
            let dcCount = rsBlocks[r].dataCount
            let ecCount = rsBlocks[r].totalCount - dcCount
            maxDcCount = max(maxDcCount, dcCount)
            maxEcCount = max(maxEcCount, ecCount)
            dcdata[r] = [Int](repeating: 0, count: dcCount)
            for i in 0..<dcdata[r].count {
                dcdata[r][i] = Int(0xff & buffer.buffer[i + offset])
            }
            offset += dcCount
            let rsPoly = QRUtil.getErrorCorrectPolynomial(ecCount)
            let rawPoly = try! QRPolynomial(dcdata[r]!, rsPoly.getLength() - 1)
            let modPoly = rawPoly.mod(rsPoly)
            ecdata[r] = [Int](repeating: 0, count: rsPoly.getLength() - 1)
            for i in 0..<ecdata[r].count {
                let modIndex = i + modPoly.getLength() - ecdata[r].count
                ecdata[r][i] = (modIndex >= 0) ? modPoly.get(modIndex) : 0
            }
        }
        var totalCodeCount = 0
        for i in 0..<rsBlocks.count {
            totalCodeCount += rsBlocks[i].totalCount
        }
        var data = [Int](repeating: 0, count: totalCodeCount)
        var index = 0
        for i in 0..<maxDcCount {
            for r in 0..<rsBlocks.count {
                if i < dcdata[r].count {
                    data[index] = dcdata[r]![i]
                    index += 1
                }
            }
        }
        for i in 0..<maxEcCount {
            for r in 0..<rsBlocks.count {
                if i < ecdata[r].count {
                    data[index] = ecdata[r]![i]
                    index += 1
                }
            }
        }
        return data
    }
}
