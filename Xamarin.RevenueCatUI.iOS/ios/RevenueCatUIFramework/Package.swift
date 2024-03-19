// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import class Foundation.ProcessInfo

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/RevenueCat/purchases-ios.git", from: "4.39.0")
]

// See https://github.com/RevenueCat/purchases-ios/pull/2989
// #if os(xrOS) can't really be used in Xcode 13, so we use this instead.

let package = Package(
    name: "RevenueCatUIFramework",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(name: "RevenueCatUIFramework",
                 targets: ["RevenueCatUIFramework"])
    ],
    dependencies: dependencies,
    targets: [
        .target(name: "RevenueCatUIFramework",
                 dependencies: [
                     .product(name: "RevenueCat",package: "purchases-ios")],
                 path: "Sources/RevenueCatUIFramework/",
                 resources: [
                     .copy("Sources/RevenueCatUIFramework/Resources/background.jpg"),
                     .process("Sources/RevenueCatUIFramework/Resources/icons.xcassets")
                 ])
    ]
)
