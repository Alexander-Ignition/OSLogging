# OSLogging

[![SPM compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/Alexander-Ignition/OSLogging/blob/master/LICENSE)

[`OSLog`](https://developer.apple.com/documentation/os/logging) logging backend for [`swift-log`](https://github.com/apple/swift-log)

- [WWDC 2016 Unified Logging and Activity Tracing](https://developer.apple.com/videos/play/wwdc2016/721/)
- logs can be seen in Console.app

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

## Usage

Override `LoggingSystem` with default `OSLog`.

```swift
LoggingSystem.bootstrap { _ in OSLogHandler() }

let logger = Logger(label: "com.example.app")
logger.info("i found you!")
// 2019-10-20 08:47:35.498086+0300 ExampleApp[6533:150683] i found you!
```

Сhoose subsystems and categories for different parts of the application

```swift
let logger = Logger(label: "com.exaple.app") { label in
    OSLogHandler(subsystem: label, category: "auth")
}

logger.info("loose control")
// 2019-10-20 08:47:35.498582+0300 ExampleApp[6533:150683] [auth] loose control
```

Custom metadata format

```swift
var logger = Logger(label: "com.exaple.app") { label in
    var hanlder = OSLogHandler(subsystem: label, category: "session")
    hanlder.formatter = { metadata in
        metadata.map { "\($0):\($1)" } .joined(separator: ", ")
    }
    return hanlder
}
logger[metadataKey: "request-id"] = "1"
logger[metadataKey: "session-id"] = "a"

logger.warning("catch me if you can")
// 2019-10-20 08:47:35.499106+0300 ExampleApp[6533:150683] [session] session-id:a, request-id:1 catch me now

```
