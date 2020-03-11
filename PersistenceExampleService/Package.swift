// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistenceExample",
    platforms: [
      .macOS(.v10_12), .iOS(.v10)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "PersistenceExampleModel",
            targets: ["PersistenceExampleModel"]),
        .library(
            name: "PersistenceExampleClient",
            targets: ["PersistenceExampleClient"]),
        .library(
            name: "PersistenceExampleOperations",
            targets: ["PersistenceExampleOperations"]),
        .library(
            name: "PersistenceExampleOperationsHTTP1",
            targets: ["PersistenceExampleOperationsHTTP1"]),
        .executable(
            name: "PersistenceExampleService",
            targets: ["PersistenceExampleService"]),
        ],
    dependencies: [
        .package(url: "https://github.com/amzn/smoke-framework.git", .branch("1_x_compatible_server")),
        .package(url: "https://github.com/amzn/smoke-aws-credentials.git", .branch("add_logging_metadata")),
        .package(url: "https://github.com/amzn/smoke-aws.git", from: "2.0.0-alpha.4"),
        .package(url: "https://github.com/amzn/smoke-dynamodb.git", from: "2.0.0-alpha.3"),
        ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "PersistenceExampleModel",
            dependencies: ["SmokeOperations"]),
        .target(
            name: "PersistenceExampleOperations",
            dependencies: ["PersistenceExampleModel", "SmokeDynamoDB"]),
        .target(
            name: "PersistenceExampleOperationsHTTP1",
            dependencies: ["PersistenceExampleOperations", "SmokeOperationsHTTP1"]),
        .target(
            name: "PersistenceExampleClient",
            dependencies: ["PersistenceExampleModel", "SmokeOperationsHTTP1", "SmokeAWSHttp"]),
        .target(
            name: "PersistenceExampleService",
            dependencies: ["PersistenceExampleOperationsHTTP1", "SmokeAWSCredentials"]),
        .testTarget(
            name: "PersistenceExampleOperationsTests",
            dependencies: ["PersistenceExampleOperations"]),
        ],
        swiftLanguageVersions: [.v5]
)
