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

import QRCodeSwift
import Foundation

let args = ProcessInfo.processInfo.arguments
let ENV = ProcessInfo.processInfo.environment

let link: String
if args.count > 1 {
    link = args.last!
} else {
    var input: String?
    print("Generate QRCode for", terminator: ": ")
    repeat { input = readLine() } while (input == nil)
    link = input!
}
let qr = try QRCode(link)

let background, foreground: String
if ENV.keys.contains("__XCODE_BUILT_PRODUCTS_DIR_PATHS") {
    background = "  "
    foreground = "MM"
} else {
    background = "\u{1B}[7m  "
    foreground = "\u{1B}[0m  "
}

print(qr.toString(filledWith: background, patchedWith: foreground))
