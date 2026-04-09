// swift-tools-version:5.9
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
            name: "EID-Governikus",
            targets: ["EID-Governikus-Target-Wrapper"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/idnow/eid-sdk-ios.git", exact: "1.3.0")
    ],
    targets: [
        .binaryTarget(
            name: "DocIDVCommon",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.2.0/DocIDVCommon.xcframework.zip",
            checksum: "64603eb5e6ae2752a3bcc6f2539f3848fff1b74177654b8c4125fb9e816afd2c"
        ),
        .binaryTarget(
            name: "DocIDV",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.2.0/DocIDV.xcframework.zip",
            checksum: "e42fa33815cea397dd0319501cc9e60cb37a456173b7f82f27f7b2e6723d1c8a"
        ),
        .binaryTarget(
            name: "DocIDVAIModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.2.0/DocIDVAIModule.xcframework.zip",
            checksum: "ef59d9e3771de0b7eeb1156a58dbdfb7a27ea939eefe322b3f1ffbac7f3a4b66"
        ),
        .binaryTarget(
            name: "DocIDVAI",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.2.0/DocIDVAI.xcframework.zip",
            checksum: "e00d7bb9a5ce515d6e293cd1cde058ade1b25f9f5617058f2bf19e6e8e3ed280"
        ),
        .binaryTarget(
            name: "DocIDVEIDGovernikusModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.2.0/DocIDVEIDGovernikusModule.xcframework.zip",
            checksum: "b63c3cc461d3d6c0b8cf9345d035af37413538c138af64711104a016e7faef79"
        ),
        .target(
            name: "DocIDV-Target-Wrapper",
            dependencies: [
                "DocIDV",
                "DocIDVCommon",
                "DocIDVAIModule",
                "DocIDVAI"
            ],
            path: "sources"
        ),
        .target(
            name: "EID-Governikus-Target-Wrapper",
            dependencies: [
                "DocIDV",
                "DocIDVCommon",
                "DocIDVAIModule",
                "DocIDVAI",
                "DocIDVEIDGovernikusModule",
                .product(name: "IDnowEIDGovernikus", package: "eid-sdk-ios")
            ],
            path: "sources-eid-governikus"
        )
    ]
)
