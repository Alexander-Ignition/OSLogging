// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "OSLogging",
    platforms: [.iOS("10.0"), .macOS("10.12"), .tvOS("10.0"), .watchOS("3.0")],
    products: [
        .library(
            name: "OSLogging",
            targets: ["OSLogging"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "OSLogging",
            dependencies: ["Logging"])
    ]
)
