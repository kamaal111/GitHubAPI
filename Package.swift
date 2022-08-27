// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitHubAPI",
    platforms: [.macOS(.v10_15), .iOS(.v13)],
    products: [
        .library(
            name: "GitHubAPI",
            targets: ["GitHubAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kamaal111/XiphiasNet.git", "7.0.0" ..< "8.0.0"),
        .package(url: "https://github.com/Quick/Quick.git", "4.0.0" ..< "5.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", "9.0.0" ..< "10.0.0"),
        .package(url: "https://github.com/kamaal111/MockURLProtocol", "0.1.1" ..< "0.2.0"),
    ],
    targets: [
        .target(
            name: "GitHubAPI",
            dependencies: [
                "XiphiasNet",
            ]
        ),
        .testTarget(
            name: "GitHubAPITests",
            dependencies: [
                "GitHubAPI",
                "Quick",
                "Nimble",
                "MockURLProtocol",
            ]
        ),
    ]
)
