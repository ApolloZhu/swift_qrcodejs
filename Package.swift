// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift_qrcodejs",
    products: [
        .library(
            name: "QRCodeSwift",
            targets: ["QRCodeSwift"]),
    ],
    targets: [
        .target(
            name: "QRCodeSwift",
            dependencies: [],
            path: "Sources/"),
        .testTarget(
            name: "QRCodeSwiftTests",
            dependencies: ["QRCodeSwift"]),
    ]
)
