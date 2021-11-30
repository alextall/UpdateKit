// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UpdateKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "UpdateKit",
            targets: ["UpdateKit"]),
    ],
    dependencies: [
        .package(name: "DataKit",
                 url: "https://github.com/alextall/DataKit.git",
                    .upToNextMajor(from: .init(0, 5, 0))),
    ],
    targets: [
        .target(
            name: "UpdateKit",
            dependencies: [
                .product(name: "HTTPClient", package: "DataKit"),
            ]),
        .testTarget(
            name: "UpdateKitTests",
            dependencies: ["UpdateKit"]),
    ]
)
