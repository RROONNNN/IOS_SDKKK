import os
public struct OSLogSink: PulseSink {
    public let id = "oslog"
    private let subsystem: String
      private let category: String

    public init(subsystem: String = "dev.pulse.sdk", category: String = "PulseEvent") {
           self.subsystem = subsystem
           self.category = category
       }

    public func write(_ event: PulseEvent) {
        let logger = Logger(subsystem: subsystem, category: category)
        logger.log(level: event.level.osLogType, "\(event.logLine, privacy: .public)")
    }

}

extension PulseLevel {
    var osLogType: OSLogType {
        switch self {
        case .verbose, .debug: .debug
        case .info: .info
        case .warn: .default
        case .error: .error
        }
    }
}
