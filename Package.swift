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
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.6.0/DocIDVCommon.xcframework.zip",
            checksum: "250e46ea12faa40916d8c05df84acd962bf69f4b0a1447197d6c299045b06faf"
        ),
        .binaryTarget(
            name: "DocIDV",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.6.0/DocIDV.xcframework.zip",
            checksum: "62af762c67214ee4442e4345424c83508bae4e3f9c82cfe344a7bf41cc3ece66"
        ),
        .binaryTarget(
            name: "DocIDVAIModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.6.0/DocIDVAIModule.xcframework.zip",
            checksum: "af03d60a31b58f84df2fdde0f97107d2cad1103ff38908abacfc992ca8dfc2a3"
        ),
        .binaryTarget(
            name: "DocIDVAI",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.6.0/DocIDVAI.xcframework.zip",
            checksum: "23d81fc2ed1a3a1d9473ad3abc624b7ebb8d7ee213c5dc7802974fefdbef45be"
        ),
        .binaryTarget(
            name: "DocIDVEIDGovernikusModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.6.0/DocIDVEIDGovernikusModule.xcframework.zip",
            checksum: "0bc52598e46835889b492d9d3790331a05ffb7e898c029f9c485250b88f7d49c"
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
