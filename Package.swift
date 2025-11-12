// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DocIDV",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "DocIDV",
            targets: ["DocIDV-Target-Wrapper"]
        ),
        .library(
            name: "DocIDV-without-XS2A",
            targets: ["DocIDV-without-XS2A-Target-Wrapper"]
        )
    ],
    // Define external dependencies (via SPM).
    dependencies: [
        .package(url: "https://github.com/idnow/sunflower-sdk-ios.git", exact: "1.4.10"),
        .package(url: "https://github.com/unissey/sdk-ios.git", exact: "4.0.0")
    ],
    targets: [
        // Define our 2 SDK internal binaries and the 2 external ones and their location.
        .binaryTarget(
            name: "DocIDV",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/DocIDV.xcframework.zip",
            checksum: "7ed1d58ae62044d8f2ae3307aaadbee11c3f42d170b462c8fe04cd167bfc0b89"
        ),
        .binaryTarget(
            name: "DocIDV-without-XS2A",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/DocIDV-without-XS2A.xcframework.zip",
            checksum: "aca609143b6f5b423dd1ffd73a1d270f7ccad0eb1d07c2341072244b897769b3"
        ),
        .binaryTarget(
            name: "ReadID_UI",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/ReadID_UI.xcframework.zip",
            checksum: "bb469af2c8af0f73933d747287d5f0dd31a44d9a699c9eb0a3843c3b1f7e77c2"
        ),
        .binaryTarget(
            name: "FaceTecSDK",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/FaceTecSDK.xcframework.zip",
            checksum: "bb25bd0fdaf166c9ed4ee4dd7b7e36e019a2cf62581495ee780287c02f4b59b3"
        )
        // Define a wrapper which will encapsulate every dependencies in it.
        .target(
            name: "DocIDV-Target-Wrapper",
            dependencies: [
                // Local DocIDV sdk binaries.
                .target(name: "DocIDV"),
                // External frameworks saved locally.
                .target(name: "FaceTecSDK"),
                .target(name: "ReadID_UI"),
                // External public frameworks.
                .product(name: "UnisseySdk", package: "sdk-ios"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios")
            ],
            path: "sources/DocIDV" // Path to an empty .swift file, needed by SPM.
        ),
        // Define a wrapper for 2nd target without XS2A library.
        .target(
            name: "DocIDV-without-XS2A-Target-Wrapper",
            dependencies: [
                // Local DocIDV sdk binaries (without XS2A lib).
                .target(name: "DocIDV-without-XS2A"),
                // External frameworks saved locally.
                .target(name: "FaceTecSDK"),
                .target(name: "ReadID_UI"),
                // External public frameworks.
                .product(name: "UnisseySdk", package: "sdk-ios"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios")
            ],
            path: "sources/DocIDV-without-XS2A" // Path to another empty .swift file, needed by SPM.
        ),
    ]
)
