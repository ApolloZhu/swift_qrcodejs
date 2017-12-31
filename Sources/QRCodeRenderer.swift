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
        
        #if os(iOS) || os(tvOS) || os(watchOS)
        static let clear: CGColor = UIColor.clear.cgColor
        #elseif os(macOS)
        static let clear: CGColor = NSColor.clear.cgColor
        #endif
    }
    
    struct QRCodeRenderer {
        private static func inContext(size: CGSize, _ action: (CGContext) -> Void) -> CGImage? {
            #if os(iOS) || os(tvOS) || os(watchOS)
                UIGraphicsBeginImageContext(size)
                defer { UIGraphicsEndImageContext() }
                if let ctx = UIGraphicsGetCurrentContext()
                { action(ctx) } else { return nil }
                return UIGraphicsGetImageFromCurrentImageContext()?.cgImage
            #else
                return nil
            #endif
        }
        
        static func generate(model: [[Bool]],
                             size: CGSize = CGSize(width: 256, height: 256),
                             colorDark: Int = 0x000000,
                             colorLight: Int = 0xFFFFFF,
                             errorCorrectLevel: QRErrorCorrectLevel = .H) -> CGImage? {
            let count = model.count
            guard count > 0 else { return nil }
            let total = min(size.width, size.height)
            let side = total / CGFloat(count)
            let xOffset = (size.width - total) / 2
            let yOffset = (size.height - total) / 2
            let dark = CGColor.fromRGB(colorDark)!
            let light = CGColor.fromRGB(colorLight)!
            
            return inContext(size: size) { context in
                context.setStrokeColor(.clear)
                context.setLineWidth(0)
                for x in 0..<count {
                    for y in 0..<count {
                        context.setFillColor(model[x][y] ? dark : light)
                        context.fill(CGRect(x: xOffset + CGFloat(x) * side,
                                            y: yOffset + CGFloat(y) * side,
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
        public var image: UIImage? {
        guard let cgImage = cgImage else { return nil }
        return UIImage(cgImage: cgImage)
        }
        #elseif os(macOS)
        public var image: NSImage? {
            guard let cgImage = cgImage else { return nil }
            return NSImage(cgImage: cgImage,
                           size: NSSize(width: size.width, height: size.height))
        }
        #endif
    }
#endif

