
/**
 * @class QRCode
 * @constructor
 * @example
 * new QRCode(document.getElementById("test"), "http://jindo.dev.naver.com/collie")
 *
 * @example
 * var oQRCode = new QRCode("test", {
 *    text : "http://naver.com",
 *    width : 128,
 *    height : 128
 * })
 *
 * oQRCode.clear() // Clear the QRCode.
 * oQRCode.makeCode("http://map.naver.com") // Re-create the QRCode.
 *
 * @param {HTMLElement|String} el target element or 'id' attribute of element.
 * @param {Object|String} vOption
 * @param {String} vOption.text QRCode link data
 * @param {Number} [vOption.width=256]
 * @param {Number} [vOption.height=256]
 * @param {String} [vOption.colorDark="#000000"]
 * @param {String} [vOption.colorLight="#ffffff"]
 * @param {QRCode.CorrectLevel} [vOption.correctLevel=QRCode.CorrectLevel.H] [L|M|Q|H]
 */
public struct QRCode {
    let text: String
    let width: Int
    let height: Int
    let typeNumber: Int
    let colorDark: Int
    let colorLight: Int
    /**
     * @name QRCode.CorrectLevel
     */
    let correctLevel: QRErrorCorrectLevel = .H
    private var _oQRCode: QRCodeModel! = nil
    
    public init(_ text: String, width: Int = 256, height: Int = 256, typeNumber: Int = 4, colorDark: Int = 0x000000, colorLight: Int = 0xFFFFFF) {
        self.text = text
        self.width = width
        self.height = height
        self.typeNumber = typeNumber
        self.colorDark = colorDark
        self.colorLight = colorLight
        makeCode(text)
    }

    /**
     * Make the QRCode
     *
     * @param {String} sText link data
     */
    public mutating func makeCode(_ sText: String) {
        _oQRCode = QRCodeModel(try! _getTypeNumber(sText, correctLevel),
                               correctLevel)
        _oQRCode.addData(sText)
        _oQRCode.make()
        // draw(self._oQRCode)
    }
}
