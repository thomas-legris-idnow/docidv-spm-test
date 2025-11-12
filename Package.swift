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
        .package(url: "https://github.com/unissey/sdk-ios.git", exact: "4.0.0"),
    ],
    targets: [
        // Define our 2 SDK internal binaries and the 2 external ones and their location.
        .binaryTarget(
            name: "DocIDV",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/DocIDV.xcframework.zip",
            checksum: "dcb1f7003e6a185988cac818729d93e3c336d089c5832f4f19f173f3dc505941"
        ),
        .binaryTarget(
            name: "DocIDV-without-XS2A",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/DocIDV-without-XS2A.xcframework.zip",
            checksum: "543b25c23ac852242bf8fb522b82924c46ed0d6aad350a1b2c82b2087e491717"
        ),
        .binaryTarget(
            name: "ReadID_UI",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/ReadID_UI.xcframework.zip",
            checksum: "b7b7e112b8a0984341f6504c9bb790481ee5260dedaf3a0c38fc4b04763acc9f"
        ),
        .binaryTarget(
            name: "FaceTecSDK",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.1.0/FaceTecSDK.xcframework.zip",
            checksum: "c67b5f72862e59f6214707760758e9a569cc0d8a0aaffbc1d17e48a8ad2e76e5"
        ),
        // Define a wrapper which will encapsulate every dependencies in it.
        .target(
            name: "DocIDV-Target-Wrapper",
            dependencies: [
                // Local DocIDV sdk binaries.
                "DocIDV",
                // External frameworks saved locally.
                "FaceTecSDK",
                "ReadID_UI",
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
                "DocIDV-without-XS2A",
                // External frameworks saved locally.
                "FaceTecSDK",
                "ReadID_UI",
                // External public frameworks.
                .product(name: "UnisseySdk", package: "sdk-ios"),
                .product(name: "SunflowerUIKit", package: "sunflower-sdk-ios")
            ],
            path: "sources/DocIDV-without-XS2A" // Path to another empty .swift file, needed by SPM.
        )
    ]
)
