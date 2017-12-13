/*
 /// Draw the QRCode
 ///
 /// @param {QRCode} oQRCode
 Drawing.prototype.draw = function (oQRCode: QRCodeModel) {
 var _elImage = self._elImage
 var _oContext = self._oContext
 var _htOption = self._htOption
 
 var nCount = oQRCode.moduleCount
 var nWidth = _htOption.width / nCount
 var nHeight = _htOption.height / nCount
 var nRoundedWidth = Math.round(nWidth)
 var nRoundedHeight = Math.round(nHeight)
 
 _elImage.style.display = "none"
 self.clear()
 
 for (var row = 0; row < nCount; row++) {
 for (var col = 0; col < nCount; col++) {
 var bIsDark = oQRCode.isDark(row, col)
 var nLeft = col * nWidth
 var nTop = row * nHeight
 _oContext.strokeStyle = bIsDark ? _htOption.colorDark : _htOption.colorLight
 _oContext.lineWidth = 1
 _oContext.fillStyle = bIsDark ? _htOption.colorDark : _htOption.colorLight
 _oContext.fillRect(nLeft, nTop, nWidth, nHeight)
 
 // 안티 앨리어싱 방지 처리
 _oContext.strokeRect(
 Math.floor(nLeft) + 0.5,
 Math.floor(nTop) + 0.5,
 nRoundedWidth,
 nRoundedHeight
 )
 
 _oContext.strokeRect(
 Math.ceil(nLeft) - 0.5,
 Math.ceil(nTop) - 0.5,
 nRoundedWidth,
 nRoundedHeight
 )
 }
 }
 }
 */

/*
 // Yet another drawing code
 func createMovieClip(_ target_mc: JSThing, _ instance_name: JSThing, _ depth: JSThing) -> JSThing {
 var qr_mc = target_mc.createEmptyMovieClip(instance_name, depth)
 var cs = 1
 make()
 for row in 0..<modules.count {
 var y = row * cs
 for col in 0..<modules[row].count {
 let x = col * cs
 let dark = modules[row][col]
 if (dark) {
 qr_mc.beginFill(0, 100)
 qr_mc.moveTo(x, y)
 qr_mc.lineTo(x + cs, y)
 qr_mc.lineTo(x + cs, y + cs)
 qr_mc.lineTo(x, y + cs)
 qr_mc.endFill()
 }
 }
 }
 return qr_mc
 }
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
