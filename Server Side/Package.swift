// swift-tools-version:4.2

import PackageDescription

let package = Package(
	name: "Cute Weather City ID",
	products: [
		.executable(name: "Cute Weather City ID", targets: ["Cute Weather City ID"])
	],
	dependencies: [
		.package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
	],
	targets: [
		.target(name: "Cute Weather City ID", dependencies: ["PerfectHTTPServer"])
	]
)
