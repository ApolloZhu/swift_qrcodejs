struct QRPolynomial {
    var num: [Int]
    init(_ num: [Int], _ shift: Int) throws {
        if (num.count == 0) {
            throw Error("\(num.count)/\(shift)")
        }
        var offset = 0
        while offset < num.count && num[offset] == 0 {
            offset += 1
        }
        self.num = [Int](repeating: 0, count: num.count - offset + shift)
        for i in 0..<num.count - offset {
            self.num[i] = num[i + offset]
        }
    }
    func get(_ index: Int) -> Int {
        return num[index]
    }

    func getLength() -> Int {
        return num.count
    }

    func multiply(_ e: QRPolynomial) -> QRPolynomial {
        var num = [Int](repeating: 0, count: getLength() + e.getLength() - 1)
        for i in 0..<getLength() {
            for j in 0..<e.getLength() {
                num[i + j] ^= QRMath.gexp(try! QRMath.glog(get(i)) + QRMath.glog(e.get(j)))
            }
        }
        return try! QRPolynomial(num, 0)
    }

    func mod(_ e: QRPolynomial) -> QRPolynomial {
        if (getLength() - e.getLength() < 0) {
            return self
        }
        let ratio = try! QRMath.glog(get(0)) - QRMath.glog(e.get(0))
        var num = [Int](repeating: 0, count: getLength())
        for i in 0..<getLength() {
            num[i] = get(i)
        }
        for i in 0..<e.getLength() {
            num[i] ^= QRMath.gexp(try! QRMath.glog(e.get(i)) + ratio)
        }
        return try! QRPolynomial(num, 0).mod(e)
    }
}
