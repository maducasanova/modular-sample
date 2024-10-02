// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Core", package: "Core"),
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
