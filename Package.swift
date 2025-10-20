// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "QuickSearch",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
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
