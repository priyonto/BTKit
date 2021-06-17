// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BTKit",
    defaultLocalization: "en",
    platforms: [.macOS(.v10_15), .iOS(.v10)],
    products: [
        .library(
            name: "BTKit",
            targets: ["BTKit"]),
    ],
    targets: [
        .target(
            name: "BTKit",
            dependencies: []),
        .testTarget(
            name: "BTKitTests",
            dependencies: ["BTKit"]),
    ]
)
