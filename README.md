# OSLogging
swift-log + os.log

## Features

- [x] Configure `OSLog`
- [x] Mapping logging levels of `Logger.Level` to `OSLogType`
- [x] Customize metadata formatter

## Instalation

Add dependency to `Package.swift`...

```swift
.package(url: "https://github.com/Alexander-Ignition/OSLogging", from: "1.0.0"),
```

... and your target

```swift
.target(name: "ExampleApp", dependencies: ["OSLogging"]),
```

## Setup for development

Create Xcode project

```bash
$ make project
```
