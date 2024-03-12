// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "QuickSearch",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "QuickSearch",
            targets: ["QuickSearch"]
        )
    ],
    targets: [
        .target(
            name: "QuickSearch"
        ),
        .testTarget(
            name: "QuickSearchTests",
            dependencies: ["QuickSearch"]
        )
    ]
)
