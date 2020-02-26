// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Counter",
    platforms: [
        .iOS(.v10),
        .watchOS(.v4),
        .tvOS(.v10),
        .macOS(.v10_14)
    ],
    products: [
        .library(
            name: "Counter",
            targets: ["Counter"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Counter",
            dependencies: []),
        .testTarget(
            name: "CounterTests",
            dependencies: ["Counter"]),
    ]
)
