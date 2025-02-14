// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoundationPlus",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "FoundationPlus",
            targets: ["FoundationPlus"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "FoundationPlus",
            resources: [.process("PrivacyInfo.xcprivacy")]
        ),
        .testTarget(
            name: "FoundationPlusTests",
            dependencies: ["FoundationPlus"],
            linkerSettings: [
                .linkedFramework(
                    "XCTest",
                    .when(platforms: [.macOS, .iOS, .tvOS, .watchOS])
                )
            ]
        ),
    ]
)
