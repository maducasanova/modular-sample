// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authentication",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
    ],
    targets: [
        .target(
            name: "Authentication"),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: ["Authentication"]),
    ]
)
