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
            checksum: "1630bc6b4cb0292d08b4443b27e0ff6f397055032da502e4594246767d0256c1"
        ),
        .binaryTarget(
            name: "DocIDV",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDV.xcframework.zip",
            checksum: "91f1e9ad2259a6232781cc10efd30c945741e1bbddd6882f2393a2b36d40fcb9"
        ),
        .binaryTarget(
            name: "DocIDVAIModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDVAIModule.xcframework.zip",
            checksum: "86122e743fb47588d430dc317af18b91e45a4bb6f01c157f5ec47ea890a21de2"
        ),
        .binaryTarget(
            name: "DocIDVAI",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDVAI.xcframework.zip",
            checksum: "57bff6ec238a6298d3a99cee3cbdb543e461f304aad95f64a749f88a2804c150"
        ),
        .binaryTarget(
            name: "DocIDVEIDGovernikusModule",
            url: "https://github.com/thomas-legris-idnow/docidv-spm-test/releases/download/1.7.0/DocIDVEIDGovernikusModule.xcframework.zip",
            checksum: "ca40d4f28b2f36c919c11fc55bb0685b2a7bf81919430859ddfd621fae290bd5"
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
