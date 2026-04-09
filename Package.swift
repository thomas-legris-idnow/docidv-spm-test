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
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDVCommon.xcframework.zip",
            checksum: "350a2e9271dc26dee357b7e455989a426a03c09f1dbad5d51b0acd5ac2eb1427"
        ),
        .binaryTarget(
            name: "DocIDV",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDV.xcframework.zip",
            checksum: "6c2447c0ffb94c1945369c75da45653604fba942df0e09a7da21450e6433fb9b"
        ),
        .binaryTarget(
            name: "DocIDVAIModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDVAIModule.xcframework.zip",
            checksum: "cff715f49d40e949d4378c49573a205f85dc09491d169967543f883793e53738"
        ),
        .binaryTarget(
            name: "DocIDVAI",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDVAI.xcframework.zip",
            checksum: "be295536612059ea48e4ab8452121d32a8768169b0b3667cadbcc7f21acb5ff5"
        ),
        .binaryTarget(
            name: "DocIDVEIDGovernikusModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDVEIDGovernikusModule.xcframework.zip",
            checksum: "54b34b67dedb4a684d8d3633a652c4e9b21a4170d849624374b41eb31d04cec2"
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
