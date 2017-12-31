/*
 Copyright (c) 2017 Zhiyu Zhu/朱智语

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#if os(watchOS)
    import WatchKit
#endif

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#else
    public struct CGSize: Equatable {

        public var width, height: Int

        public static var zero: CGSize { return CGSize()  }

        public init(width: Int = 0, height: Int = 0) {
            self.width = width
            self.height = height
        }

        public static func ==(lhs: CGSize, rhs: CGSize) -> Bool {
            return lhs.width == rhs.width
                && lhs.height == rhs.height
        }
    }
#endif

public class QRCode {
    let text: String
    let size: CGSize
    let colorDark: Int
    let colorLight: Int
    let correctLevel: QRErrorCorrectLevel
    private let typeNumber: Int
    private let model: QRCodeModel

    public init?(_ text: String,
                 size: CGSize = CGSize(width: 256, height: 256),
                 colorDark: Int = 0x000000,
                 colorLight: Int = 0xFFFFFF,
                 errorCorrectLevel: QRErrorCorrectLevel = .H) {
        guard let typeNumber = try? QRCodeType
            .typeNumber(of: text, errorCorrectLevel: errorCorrectLevel),
            let model = QRCodeModel(text: text,
                                    typeNumber: typeNumber,
                                    errorCorrectLevel: errorCorrectLevel)
            else { return nil }
        self.typeNumber = typeNumber
        self.model = model
        self.text = text
        self.size = size
        self.colorDark = colorDark
        self.colorLight = colorLight
        self.correctLevel = errorCorrectLevel
    }

    public private(set) lazy var imageCodes: [[Bool]]! = {
        return (0..<model.moduleCount).map { r in
            (0..<model.moduleCount).map { c in
                return model.isDark(r, c)
            }
        }
    }()

    public func toString(filledWith black: Any,
                         patchedWith white: Any) -> String {
        guard let code = imageCodes else { return "" }
        let base = (0..<code.count+2).reduce("") { (built,_) in "\(built)\(white)" }
        return code.reduce("\(base)\n") { $0 +
            "\($1.reduce("\(white)") { "\($0)\($1 ? black : white)" })\(white)\n"
            } + base
    }
}
