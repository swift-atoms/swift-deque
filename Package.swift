// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-deque",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Deque",
            targets: ["Deque"]
        ),
        .library(
            name: "Deque Standard Library Integration",
            targets: ["Deque Standard Library Integration"]
        ),
        .library(
            name: "Deque Apple Foundation Integration",
            targets: ["Deque Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Deque",
            dependencies: []
        ),
        .target(
            name: "Deque Standard Library Integration",
            dependencies: ["Deque"]
        ),
        .target(
            name: "Deque Apple Foundation Integration",
            dependencies: [
                "Deque",
                "Deque Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Deque Tests",
            dependencies: ["Deque"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem
}
