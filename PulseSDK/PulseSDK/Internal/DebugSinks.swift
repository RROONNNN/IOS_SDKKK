import Foundation

enum DebugSinks {

    static func make() -> [any PulseSink] {
#if DEBUG
       return [EventNameLinterSink()]
       #else
       return []
       #endif
    }
}

#if DEBUG
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
#endif
