// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QRCodeSwiftCLI",
    products: [
        .executable(
            name: "QRCodeSwiftCLI",
            targets: ["QRCodeSwiftCLI"]),
    ],
    dependencies: [
        .package(path: ".."),
    ],
    targets: [
        .target(
            name: "QRCodeSwiftCLI",
            dependencies: ["QRCodeSwift"],
            path: "."),
    ]
)
