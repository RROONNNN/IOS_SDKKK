import Foundation

/// Debug-only sinks. Compiled into every build of the SDK, but only enabled when
/// the host app sets `PulseConfig.debugMode`.
enum DebugSinks {
    static func make(enabled: Bool) -> [any PulseSink] {
        enabled ? [EventNameLinterSink()] : []
    }
}

struct EventNameLinterSink: PulseSink {
    let id = "debug-name-linter"
//    snake_case
    func write(_ event: PulseEvent) {
        let isSnakeCase = event.name.range(of: "^[a-z][a-z0-9_]*$", options: .regularExpression) != nil
        if !isSnakeCase {
            InternalLog.warning("Event name '\(event.name)' should be snake_case (debug-only warning)")
        }
    }
}
