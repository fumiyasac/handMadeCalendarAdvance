// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalculateCalendarLogic",
    products: [
        .library(
            name: "CalculateCalendarLogic",
            targets: ["CalculateCalendarLogic"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CalculateCalendarLogic",
            path: "CalculateCalendarLogic",
            dependencies: []),
        .testTarget(
            name: "CalculateCalendarLogicTests",
            dependencies: ["CalculateCalendarLogic"]),
    ],
    swiftLanguageVersions: [.v5]
)
