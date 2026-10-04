import SwiftUI
import PulseSDK

@main
struct PulseDemoApp: App {
    private let store: EventStore

    init() {
        let store = EventStore()
        self.store = store

        var config = PulseConfig()
        #if DEBUG
        config.minLevel = .verbose
        #else
        config.minLevel = .info
        #endif
        config.environment = "staging"

        Pulse.configure(config, sinks: [OSLogSink(), StoreSink(store: store), FlakySink()])
        Pulse.log("app_started", attributes: ["screen": "launch"])
    }

    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
