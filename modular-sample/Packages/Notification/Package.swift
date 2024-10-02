// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Notification",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Notification",
            targets: ["Notification"]),
    ],
    targets: [
        .target(
            name: "Notification"),
        .testTarget(
            name: "NotificationTests",
            dependencies: ["Notification"]),
    ]
)
