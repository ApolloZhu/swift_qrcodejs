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

import CoreGraphics

struct QRCodeRenderer {
    static func generate(width: Int = 256,
                  height: Int = 256,
                  colorDark: Int = 0x000000,
                  colorLight: Int = 0xFFFFFF,
                  errorCorrectLevel: QRErrorCorrectLevel = .H) -> CGImage! {
        return nil
    }
}
