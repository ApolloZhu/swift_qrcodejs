# QRCodeSwift (swift_qrcodejs)


[![Latest Release](https://img.shields.io/github/v/release/ApolloZhu/swift_qrcodejs?sort=semver)](https://github.com/ApolloZhu/swift_qrcodejs/releases)
[![MIT License](https://img.shields.io/github/license/ApolloZhu/swift_qrcodejs.svg)](./LICENSE)
[![Swift 5.0+](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FApolloZhu%2Fswift_qrcodejs%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ApolloZhu/swift_qrcodejs)
[![Compatible with All Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FApolloZhu%2Fswift_qrcodejs%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/ApolloZhu/swift_qrcodejs)

[![Documentation](https://apollozhu.github.io/swift_qrcodejs/badge.svg)](https://apollozhu.github.io/swift_qrcodejs)
[![Code Coverage](https://codecov.io/gh/ApolloZhu/swift_qrcodejs/branch/master/graphs/badge.svg)](https://codecov.io/gh/ApolloZhu/swift_qrcodejs/branch/master)
[![CocoaPods Compatible](https://github.com/ApolloZhu/swift_qrcodejs/workflows/CocoaPods/badge.svg)](https://swiftpackageindex.com/ApolloZhu/swift_qrcodejs)
[![Swift Package Manager Compatible](https://github.com/ApolloZhu/swift_qrcodejs/workflows/Swift%20Package%20Manager/badge.svg)](https://swiftpackageindex.com/ApolloZhu/swift_qrcodejs)
[![Carthage Compatible](https://github.com/ApolloZhu/swift_qrcodejs/workflows/Carthage/badge.svg)](https://github.com/Carthage/Carthage)

Cross-platform QRCode generator written in pure Swift, aiming to solve the awkward situation that there's no CIFilter for QRCode generation on Apple Watches.

## Installation

<details>
<summary><strong>Swift Package Manager</strong></summary>

```swift
dependencies: [
    .package(url: "https://github.com/ApolloZhu/swift_qrcodejs.git", from: "2.1.0"),
]
```

... then add `QRCodeSwift` module/target from package `swift_qrcodejs` as your dependency.

</details>

<details>
<summary><strong>CocoaPods</strong></summary>

```ruby
pod 'swift_qrcodejs'
```

</details>

<details>
<summary><strong>Carthage</strong></summary>

```ruby
github "ApolloZhu/swift_qrcodejs" ~> 2.1.0
```

</details>

<details>
<summary><strong>Manually</strong></summary>

Add all the `.swift` files from the `Sources` folder into your project.

</details>

## Usage

```swift
import QRCodeSwift

guard let qrCode = try? QRCode("Hello World!") else {
    fatalError("Failed to generate QRCode")
}
print(qrCode.toString(filledWith: "##", patchedWith: "  "))
```

For more, checkout the [documentation](https://apollozhu.github.io/swift_qrcodejs).

## Example Projects

- [QRCodeSwiftCLI](./Example/main.swift): lightweight command line tool to generate QRCodes.
- [EFQRCode](https://github.com/EyreFree/EFQRCode): popular Swift framework that generates stylized QRCode images.
- [Apple Watch Bilibili](https://github.com/ApolloZhu/Apple-Watch-Bilibili): login onto bilibili with QRCode.

## License

MIT License. Modified based on [qrcodejs](https://github.com/davidshimjs/qrcodejs).
See [LICENSE](./LICENSE) and each individual file header for more information.
