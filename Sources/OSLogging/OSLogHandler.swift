import Foundation
@_exported import Logging
@_exported import os.log

@available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *)
public struct OSLogHandler: LogHandler {

    public let log: OSLog

    public var levels: [Logger.Level: OSLogType] = [
        .trace: .debug,
        .debug: .debug,
        .info: .info,
        .notice: .info,
        .warning: .info,
        .error: .error,
        .critical: .fault
    ]

    public var type: OSLogType {
        return levels[logLevel, default: .default]
    }

    public init(subsystem: String, category: String) {
        self.log = OSLog(subsystem: subsystem, category: category)
    }

    public init(log: OSLog = .default) {
        self.log = log
    }

    // MARK: - Format

    public var formatter: (Logger.Metadata) -> String? = OSLogHandler.string

    private var prefix: String?

    public static func string(from metadata: Logger.Metadata) -> String? {
        guard !metadata.isEmpty else { return nil }
        return metadata.map { "\($0)=\($1)" } .joined(separator: " ")
    }

    // MARK: - LogHandler

    public var logLevel: Logger.Level = .info

    public var metadata = Logger.Metadata() {
        didSet {
            prefix = formatter(metadata)
        }
    }

    public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        get {
            return metadata[key]
        }
        set(newValue) {
            metadata[key] = newValue
        }
    }

    public func log(level: Logger.Level,
                    message: Logger.Message,
                    metadata: Logger.Metadata?,
                    file: String, function: String, line: UInt) {

        var prefix = self.prefix
        if let metadata = metadata, !metadata.isEmpty {
            prefix = formatter(self.metadata.merging(metadata) { _, new in new })
        }
        let string = prefix.map { "\($0) \(message)" } ?? "\(message)"
        os_log("%{public}@", log: log, type: type, string)
    }

}
