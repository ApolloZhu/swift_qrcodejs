#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(watchOS)
    import WatchKit
#elseif os(macOS)
    import AppKit
#endif

public class QRCode {
    let text: String
    let width: Int
    let height: Int
    let colorDark: Int
    let colorLight: Int
    let correctLevel: QRErrorCorrectLevel
    private let typeNumber: Int
    private lazy var model: QRCodeModel = QRCodeModel(text: text,
                                                      typeNumber: typeNumber,
                                                      errorCorrectLevel: correctLevel)
    
    public init?(_ text: String,
                 width: Int = 256,
                 height: Int = 256,
                 colorDark: Int = 0x000000,
                 colorLight: Int = 0xFFFFFF,
                 errorCorrectLevel: QRErrorCorrectLevel = .H) {
        guard let typeNumber = try? QRCodeType
            .typeNumber(of: text, errorCorrectLevel: errorCorrectLevel)
            else { return nil }
        self.typeNumber = typeNumber
        
        self.text = text
        self.width = width
        self.height = height
        self.colorDark = colorDark
        self.colorLight = colorLight
        self.correctLevel = errorCorrectLevel
    }
    
    public private(set) lazy var imageCodes: [[Bool]]! = {
        do {
            return try model.modules.map {
                try $0.map {
                    if $0 == nil { throw Error() }
                    return $0!
                }
            }
        } catch {
            return nil
        }
    }()
    
    public private(set) lazy var cgImage: CGImage! = {
        return QRCodeRenderer.generate(width: width, height: height, colorDark: colorDark, colorLight: colorLight, errorCorrectLevel: correctLevel)
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
                       size: NSSize(width: width, height: height))
    }()
    #endif
}
