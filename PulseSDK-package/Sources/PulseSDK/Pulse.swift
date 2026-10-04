import Synchronization

public enum Pulse {
    public static let version = "0.1.0"
    private static let engine = Mutex<PulseEngine?>(nil)

    public static var isConfigured: Bool {
        engine.withLock { $0 != nil }
    }

    public static var activeSinkIDs: [String] {
        engine.withLock { $0?.sinkIDs ?? [] }
    }
    public static func configure(
        _ config: PulseConfig = PulseConfig(),
        sinks: [any PulseSink] = [OSLogSink()]

    ) {
        let created = engine.withLock { current -> Bool in
                guard current == nil else { return false }
                current = PulseEngine(config: config, sinks: sinks + DebugSinks.make())
                return true
            }
        if created {
                InternalLog.info("Pulse \(version) configured env=\(config.environment)")
            } else {
                InternalLog.warning("Pulse.configure() called more than once — ignored.")
            }
    }
    public static func log(
        _ name: String,
        level: PulseLevel = .info,
        attributes: [String: String] = [:]
    ) {
        guard let current = engine.withLock({ $0 }) else { return }
        current.submit(PulseEvent(name: name, level: level, attributes: attributes))
    }

}
