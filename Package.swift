// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "RoundedPath",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "RoundedPath",
            targets: ["RoundedPath"]),
    ],
    targets: [
        .target(
            name: "RoundedPath",
            dependencies: []),
    ]
)
