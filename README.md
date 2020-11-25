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

<details>
<summary>with Xcode</summary>

More details in the [Official Guide](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app),
but in general:

1. Select in the menu bar of Xcode: `File` > `Swift Packages` > `Add Package Dependency`
2. Enter https://github.com/ApolloZhu/swift_qrcodejs.git
2. Next, specify the version resolving rule as "Up to Next Major"
3. Finish with choosing `QRCodeSwift` library and add it to your app target.

</details>

<details>
<summary>with <code>Package.swift</code></summary>

```swift
dependencies: [
    .package(url: "https://github.com/ApolloZhu/swift_qrcodejs.git", from: "2.2.2"),
]
```

... then add `QRCodeSwift` module/target from package `swift_qrcodejs` as your dependency.

</details>

</details>

<details>
<summary><strong>CocoaPods</strong></summary>

```ruby
pod 'swift_qrcodejs', '~> 2.2.2'
```

</details>

<details>
<summary><strong>Carthage</strong></summary>

I assume you know what you are doing (because I don't), but you probably need something like this:

```ruby
github "ApolloZhu/swift_qrcodejs" ~> 2.2.2
```

Note that [Carthage doesn't work with Xcode 12](https://github.com/Carthage/Carthage/issues/3019)
(but here's a [workaround](https://github.com/Carthage/Carthage/blob/master/Documentation/Xcode12Workaround.md)).

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
