// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Analytics",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Analytics",
            targets: ["Analytics"]),
    ],
    targets: [
        .target(
            name: "Analytics"),
        .testTarget(
            name: "AnalyticsTests",
            dependencies: ["Analytics"]),
    ]
)
