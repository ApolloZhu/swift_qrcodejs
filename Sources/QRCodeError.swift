/*
 Copyright (c) 2017-2020 ApolloZhu <public-apollonian@outlook.com>
 
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

/// All possible errors that could occur when constructing `QRCode`.
public enum QRCodeError: Error {
    /// The thing you want to save is too large for `QRCode`.
    case dataLengthExceedsCapacityLimit
    /// Can not encode the given string using the specified encoding.
    case text(String, incompatibleWithEncoding: String.Encoding)
    /// Fill a new issue on GitHub with swift_qrcodejs, or submit a pull request.
    case internalError(ImplmentationError)

    /// Should probably contact developer is you ever see any of these.
    public enum ImplmentationError {
        /// swift_qrcodejs fail to determine how large is the data.
        case dataLengthIndeterminable
        /// swift_qrcodejs fail to find appropriate container for your data.
        case dataLength(Int, exceedsCapacityLimit: Int)
        /// swift_qrcodejs fail to use some internal class correctly.
        case constructingEmptyPolynomial
    }
}
