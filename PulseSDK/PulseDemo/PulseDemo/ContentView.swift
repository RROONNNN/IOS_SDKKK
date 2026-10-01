//

import SwiftUI
import PulseSDK

struct ContentView: View {
    @ObservedObject var store: EventStore

    var body: some View {
        NavigationStack {
            List {
                Section("SDK") {
                    LabeledContent("Version", value: Pulse.version)
                    LabeledContent("Configured", value: Pulse.isConfigured ? "yes" : "no")
                    LabeledContent("Sinks", value: Pulse.activeSinkIDs.joined(separator: ", "))

                    Section("Actions") {
                        Button("Pulse.log(\"button_clicked\")") {
                            Pulse.log("button_clicked", attributes: ["screen": "main"])
                        }
                        Button("Pulse.log(\"Bad Event Name\")") {
                            Pulse.log("Bad Event Name")
                        }
                        Button("Pulse.log(\"fail_me\")") {
                            Pulse.log("fail_me", level: .warn)
                        }
                        Button("Spam 1000 events") {
                            for index in 0..<1000 {
                                Pulse.log("spam_\(index)", level: .debug)
                            }
                        }
                    }

                }
                Section("Recent events (StoreSink)") {
                    ForEach(Array(store.lines.enumerated()), id: \.offset) { _, line in
                        Text(line)
                            .font(.caption.monospaced())
                    }
                }
            }
            .navigationTitle("Pulse Demo")
        }
    }
}



