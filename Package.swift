// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "CustomNavigationContent",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "CustomNavigationContent",
            targets: ["CustomNavigationContent"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CustomNavigationContent",
            dependencies: [],
            path: "Sources")
    ]
)
