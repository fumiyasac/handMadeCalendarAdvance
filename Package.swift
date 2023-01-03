// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalculateCalendarLogic",
    products: [
        .library(
            name: "CalculateCalendarLogic",
            targets: ["CalculateCalendarLogic"]
        )
    ],
    targets: [
        .target(
            name: "CalculateCalendarLogic",
            path: "CalculateCalendarLogic"
        ),
        .testTarget(
            name: "CalculateCalendarLogicTests",
            dependencies: ["CalculateCalendarLogic"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
