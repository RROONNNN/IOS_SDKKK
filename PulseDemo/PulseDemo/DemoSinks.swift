import Foundation
import PulseSDK
internal import Combine

@MainActor
final class EventStore: ObservableObject {
    @Published private(set) var lines: [String] = []

    func append(_ line: String) {
        lines.insert(line, at: 0)
             if lines.count > 30 {
                 lines.removeLast()
             }
    }
}

struct StoreSink: PulseSink {
    let id = "demo-store"
    let store: EventStore

    func write (_ event: PulseEvent) {
        let line = event.logLine

        Task { @MainActor in
                  store.append(line)
              }

    }
}

/// Sink cố tình lỗi, để chứng minh SDK không crash khi một sink hỏng.
struct FlakySink: PulseSink {
    struct Failure: Error {}

    let id = "flaky"

    func write(_ event: PulseEvent) throws {
        if event.name == "fail_me" {
            throw Failure()
        }
    }
}


