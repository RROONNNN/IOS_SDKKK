import os

enum InternalLog {
    private static var logger: Logger {
        Logger(subsystem: "dev.pulse.sdk", category: "Pulse")
    }

    static func info(_ message: String) {
            logger.info("\(message, privacy: .public)")
        }

    static func warning(_ message: String) {
        logger.warning("\(message, privacy: .public)")
    }
}
