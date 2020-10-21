/*
 Copyright (c) 2012 davidshimjs
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

/// Error resilience level.
///
/// - Note: higher the level, larger the size.
public enum QRErrorCorrectLevel: CaseIterable {
    /// Error resilience level:  7%.
    case L
    /// Error resilience level: 15%.
    case M
    /// Error resilience level: 25%.
    case Q
    /// Error resilience level: 30%.
    case H
}

extension QRErrorCorrectLevel {
    var pattern: Int {
        switch self {
        case .L: return 1
        case .M: return 0
        case .Q: return 3
        case .H: return 2
        }
    }

    var offset: Int {
        switch self {
        case .L: return 0
        case .M: return 1
        case .Q: return 2
        case .H: return 3
        }
    }
}

#if canImport(CoreImage)
extension QRErrorCorrectLevel {
    /// Input value for CIFilter.
    public var ciQRCodeGeneratorInputCorrectionLevel: String {
        switch self {
        case .L: return "l"
        case .M: return "m"
        case .Q: return "q"
        case .H: return "h"
        }
    }
}
#endif
