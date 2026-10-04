import Foundation

final class PulseEngine: Sendable {
    let sinkIDs: [String]
    private let minLevel: PulseLevel
    private let continuation: AsyncStream<PulseEvent>.Continuation

    init(config: PulseConfig, sinks: [any PulseSink] ) {
        print("sinks: \(sinks)")
        let capacity = min(max(config.maxQueueSize, 1), 10_000)
        if capacity != config.maxQueueSize {
            InternalLog.warning("maxQueueSize \(config.maxQueueSize) is out of range, using \(capacity)")
        }
        let (stream, continuation) = AsyncStream.makeStream(
            of: PulseEvent.self,
            bufferingPolicy: .bufferingNewest(capacity)
        )
        self.continuation = continuation
                self.minLevel = config.minLevel
                self.sinkIDs = sinks.map(\.id)

        Task.detached(priority: .utility) {
            for await event in stream {
                let enriched = event.withAttributes(["env": config.environment])
                for sink in sinks {
                    do {
                        try sink.write(enriched)
                    } catch {
                        InternalLog.warning("Sink '\(sink.id)' failed: \(error)")
                    }
                }
            }
        }
    }
    func submit(_ event: PulseEvent) {
        guard event.level >= minLevel else { return }
        continuation.yield(event)
    }

    deinit {
        continuation.finish()
    }

}
