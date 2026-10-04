import Foundation
public struct PulseEvent: Sendable {
    public let name: String
    public let level: PulseLevel
    public let attributes: [String: String]
    public let timestamp: Date

public init (
    name: String,
        level: PulseLevel = .info,
        attributes: [String: String] = [:],
        timestamp: Date = Date()
)
{
    self.name = name
            self.level = level
            self.attributes = attributes
            self.timestamp = timestamp
}

    public func withAttributes(_ extra: [String: String]) -> PulseEvent {
           PulseEvent(
               name: name,
               level: level,
               attributes: attributes.merging(extra) { _, new in new },
               timestamp: timestamp
           )
       }
    /// output example: "[INFO] app_started {env=staging, screen=launch}"
    public var logLine: String {
        guard !attributes.isEmpty else {
            return "[\(level)] \(name)"
        }
        let pairs = attributes
                   .sorted { $0.key < $1.key }
                   .map { "\($0.key)=\($0.value)" }
                   .joined(separator: ", ")
               return "[\(level)] \(name) {\(pairs)}"
    }
}
