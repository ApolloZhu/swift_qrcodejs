#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit
    extension UIColor {
        convenience init(rgb: Int) {
            self.init(red: CGFloat((rgb >> 16) & 0xFF) / 255,
                      green: CGFloat((rgb >> 8) & 0xFF) / 255,
                      blue: CGFloat(rgb & 0xFF) / 255,
                      alpha: 1)
        }
    }
#elseif os(macOS)
    import AppKit
#endif

#if os(watchOS)
    import WatchKit
#endif

#if os(iOS) || os(tvOS) || os(watchOS) || os(macOS)
    extension CGColor {
        static func fromRGB(_ rgb: Int) -> CGColor! {
            #if os(iOS) || os(tvOS) || os(watchOS)
                return UIColor(rgb: rgb).cgColor
            #elseif os(macOS)
                return nil
            #endif
        }
    }

    struct QRCodeRenderer {
        private static func inContext(size: CGSize, _ action: (CGContext!) -> Void) -> CGImage! {
            #if os(iOS) || os(tvOS) || os(watchOS)
                UIGraphicsBeginImageContext(size)
                defer { UIGraphicsEndImageContext() }
                action(UIGraphicsGetCurrentContext())
                return UIGraphicsGetImageFromCurrentImageContext()?.cgImage
            #else
                return nil
            #endif
        }

        static func generate(model: [[Bool]],
                             size: CGSize = CGSize(width: 256, height: 256),
                             colorDark: Int = 0x000000,
                             colorLight: Int = 0xFFFFFF,
                             errorCorrectLevel: QRErrorCorrectLevel = .H) -> CGImage! {
            let count = model.count
            guard count > 0 else { return nil }
            let total = min(size.width, size.height)
            let side = total / CGFloat(count)
            let xOffset = (size.width - total) / 2
            let yOffset = (size.height - total) / 2
            let dark = CGColor.fromRGB(colorDark)!
            let light = CGColor.fromRGB(colorLight)!

            return inContext(size: size) { context in
                for x in 0..<count {
                    for y in 0..<count {
                        context.setFillColor(model[x][y] ? dark : light)
                        context.fill(CGRect(x: xOffset + CGFloat(x),
                                            y: yOffset + CGFloat(y),
                                            width: side,
                                            height: side))
                    }
                }
            }
        }
    }

    extension QRCode {
        public var cgImage: CGImage! {
            guard let codes = imageCodes else { return nil }
            return QRCodeRenderer.generate(model: codes,
                                           size: size,
                                           colorDark: colorDark, colorLight: colorLight,
                                           errorCorrectLevel: correctLevel)
        }

        #if os(iOS) || os(tvOS) || os(watchOS)
        public var image: UIImage! {
            guard let cgImage = cgImage else { return nil }
            return UIImage(cgImage: cgImage)
        }
        #elseif os(macOS)
        public var image: NSImage! {
            guard let cgImage = cgImage else { return nil }
            return NSImage(cgImage: cgImage,
                           size: NSSize(width: size.width, height: size.height))
        }
        #endif
    }
#endif

