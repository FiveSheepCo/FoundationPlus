// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuintKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        // The full QuintKit package with all modules included.
        .library(
            name: "QuintKit",
            targets: ["QuintKitCore", "QuintKitAlerting", "QuintKitNetworking", "QuintKitUI"]
        ),
        
        // Core module.
        // Provides foundational extensions, general helpers and shared core functionality.
        .library(
            name: "QuintKit Core",
            targets: ["QuintKitCore"]
        ),
        
        // Alerting module.
        // Provides an easier way to display cross-platform alerting prompts.
        .library(
            name: "QuintKit Alerting",
            targets: ["QuintKitAlerting"]
        ),
        
        // Networking module.
        // Provides an easier way to accomplish complex asynchronous networking tasks.
        .library(
            name: "QuintKit Networking",
            targets: ["QuintKitNetworking"]
        ),
        
        // UI module.
        // Provides cross-platform UI components.
        .library(
            name: "QuintKit UI",
            targets: ["QuintKitUI"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "QuintKitCore"),
        .target(name: "QuintKitAlerting", dependencies: ["QuintKitCore"]),
        .target(name: "QuintKitNetworking", dependencies: ["QuintKitCore"]),
        .target(name: "QuintKitUI", dependencies: ["QuintKitCore"]),
        .testTarget(
            name: "QuintKitTests",
            dependencies: [
                "QuintKitCore",
                "QuintKitAlerting",
                "QuintKitNetworking",
                "QuintKitUI"
            ]
        ),
    ]
)
