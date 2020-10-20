// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift_qrcodejs",
    products: [
        .library(
            name: "swift_qrcodejs",
            targets: ["swift_qrcodejs"]),
        .executable(
            name: "swift_qrcodejs-cli",
            targets: ["swift_qrcodejs-cli"]),
    ],
    targets: [
        .target(
            name: "swift_qrcodejs",
            dependencies: [],
            path: "Sources/"),
        .target(
            name: "swift_qrcodejs-cli",
            dependencies: ["swift_qrcodejs"],
            path: "Example/"),
        .testTarget(
            name: "swift_qrcodejsTests",
            dependencies: ["swift_qrcodejs"]),
    ]
)
