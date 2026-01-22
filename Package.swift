// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Software Name: accessibility-statement-lib-ios
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: Apache-2.0

import PackageDescription

let package = Package(
    name: "DeclarationAccessibility",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v13), // Not offically supported, but for build and test of Swift package
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DeclarationAccessibility",
            targets: ["DeclarationAccessibility"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", exact: "1.4.5"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DeclarationAccessibility",
            dependencies: [],
            resources: [.copy("Resources/Assets.xcassets")]),
        .testTarget(
            name: "DeclarationAccessibilityTests",
            dependencies: ["DeclarationAccessibility"]),
    ])
