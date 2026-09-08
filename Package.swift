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

        .library(name: "Queue DoubleEnded Primitive", targets: ["Queue DoubleEnded Primitive"]),

        .library(name: "Queue DoubleEnded", targets: ["Queue DoubleEnded"]),

        .library(name: "Deque", targets: ["Deque"]),

        .library(
            name: "Queue DoubleEnded Small Primitive",
            targets: ["Queue DoubleEnded Small Primitive"]
        ),

    ],
    dependencies: [
        .package(url: "https://github.com/swift-molecules/swift-storage-memory.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-store.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-queue.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-buffer.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-ring.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-molecules/swift-memory-small.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-storage.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership-shared.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-memory.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-allocation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-affine.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Queue DoubleEnded Primitive",
            dependencies: [
                .product(name: "Queue Primitive", package: "swift-queue"),
                .product(name: "Buffer", package: "swift-buffer"),
                .product(name: "Buffer", package: "swift-buffer"),
                .product(name: "Buffer Ring Primitive", package: "swift-buffer-ring"),
                .product(
                    name: "Buffer Ring Bounded Primitive",
                    package: "swift-buffer-ring"
                ),
                .product(name: "Store", package: "swift-store"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(
                    name: "Storage Memory",
                    package: "swift-storage-memory"
                ),
                .product(name: "Memory", package: "swift-memory"),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Ordinal",
                    package: "swift-ordinal"
                ),
                .product(
                    name: "Affine",
                    package: "swift-affine"
                ),
            ]
        ),

        .target(
            name: "Queue DoubleEnded",
            dependencies: [
                "Queue DoubleEnded Primitive",
                .product(name: "Queue Primitive", package: "swift-queue"),
                .product(name: "Buffer", package: "swift-buffer"),
                .product(name: "Buffer", package: "swift-buffer"),
                .product(name: "Buffer Ring Primitive", package: "swift-buffer-ring"),
                .product(
                    name: "Buffer Ring Bounded Primitive",
                    package: "swift-buffer-ring"
                ),
                .product(name: "Store", package: "swift-store"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(
                    name: "Storage Memory",
                    package: "swift-storage-memory"
                ),
                .product(name: "Memory", package: "swift-memory"),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Index", package: "swift-index"),
                .product(
                    name: "Ordinal",
                    package: "swift-ordinal"
                ),
                .product(
                    name: "Affine",
                    package: "swift-affine"
                ),
            ]
        ),

        .target(
            name: "Queue DoubleEnded Small Primitive",
            dependencies: [
                "Queue DoubleEnded Primitive",
                .product(name: "Buffer", package: "swift-buffer"),
                .product(name: "Buffer Ring Primitive", package: "swift-buffer-ring"),
                .product(name: "Store", package: "swift-store"),
                .product(
                    name: "Storage Memory",
                    package: "swift-storage-memory"
                ),
                .product(
                    name: "Memory Allocator",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Memory Small", package: "swift-memory-small"),
            ]
        ),

        .target(
            name: "Deque",
            dependencies: [
                "Queue DoubleEnded",
                .product(name: "Queue Primitive", package: "swift-queue"),
                .product(name: "Store", package: "swift-store"),
                .product(name: "Buffer", package: "swift-buffer"),
            ]
        ),

        .testTarget(
            name: "Queue DoubleEnded Tests",
            dependencies: [
                "Deque",
                "Queue DoubleEnded Small Primitive",
                .product(name: "Buffer Ring", package: "swift-buffer-ring"),
                .product(
                    name: "Buffer Test Support",
                    package: "swift-buffer"
                ),
                .product(name: "Memory Small", package: "swift-memory-small"),
                .product(
                    name: "Tagged",
                    package: "swift-tagged"
                ),
                .product(
                    name: "Ordinal",
                    package: "swift-ordinal"
                ),
            ]
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
