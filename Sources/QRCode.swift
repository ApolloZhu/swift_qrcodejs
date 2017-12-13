#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

#if os(watchOS)
    import WatchKit
#endif

public class QRCode {
    let text: String
    let size: CGSize
    let colorDark: Int
    let colorLight: Int
    let correctLevel: QRErrorCorrectLevel
    private let typeNumber: Int
    private lazy var model: QRCodeModel = QRCodeModel(text: text,
                                                      typeNumber: typeNumber,
                                                      errorCorrectLevel: correctLevel)

    public init?(_ text: String,
                 size: CGSize = CGSize(width: 256, height: 256),
                 colorDark: Int = 0x000000,
                 colorLight: Int = 0xFFFFFF,
                 errorCorrectLevel: QRErrorCorrectLevel = .H) {
        guard let typeNumber = try? QRCodeType
            .typeNumber(of: text, errorCorrectLevel: errorCorrectLevel)
            else { return nil }
        self.typeNumber = typeNumber

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

    public private(set) lazy var cgImage: CGImage! = {
        guard let codes = imageCodes else { return nil }
        return QRCodeRenderer.generate(model: codes,
                                       size: size,
                                       colorDark: colorDark, colorLight: colorLight,
                                       errorCorrectLevel: correctLevel)
    }()

    #if os(iOS) || os(tvOS) || os(watchOS)
    public private(set) lazy var image: UIImage! = {
        guard let cgImage = cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }()
    #elseif os(macOS)
    public private(set) lazy var image: NSImage! = {
        guard let cgImage = cgImage else { return nil }
        return NSImage(cgImage: cgImage,
                       size: NSSize(width: size.width, height: size.height))
    }()
    #endif

    public func toString(filledWith black: Any,
                         patchedWith white: Any) -> String {
        guard let code = imageCodes else { return "" }
        let base = (0..<code.count+2).reduce("") { (built,_) in "\(built)\(white)" }
        return code.reduce("\(base)\n") { $0 +
            "\($1.reduce("\(white)") { "\($0)\($1 ? black : white)" })\(white)\n"
        } + base
    }
}
