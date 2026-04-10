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
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.8.0/DocIDVCommon.xcframework.zip",
            checksum: "96a6d866df8ea0fb18dec9619e3cf973cb98420f75c786b9e0b416a20368378d"
        ),
        .binaryTarget(
            name: "DocIDV",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.8.0/DocIDV.xcframework.zip",
            checksum: "c47f759b0374c318fe1fd934e71f49aca11cdb387cd2a26fe3b13cde25eeec8e"
        ),
        .binaryTarget(
            name: "DocIDVAIModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.8.0/DocIDVAIModule.xcframework.zip",
            checksum: "e48f65993c7f5e3e7ff718fc9e270dfd5f952142592cc5b633901c2198cde293"
        ),
        .binaryTarget(
            name: "DocIDVAI",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.8.0/DocIDVAI.xcframework.zip",
            checksum: "99b602c1ee8146454410f1af3da9a226014d72ec2155003011149060707eac85"
        ),
        .binaryTarget(
            name: "DocIDVEIDGovernikusModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.8.0/DocIDVEIDGovernikusModule.xcframework.zip",
            checksum: "891cf22ac701ba8ff478fa37ec2ff9992091b25a63cb191712653bc2b18d03ba"
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
