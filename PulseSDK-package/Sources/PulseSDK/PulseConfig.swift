public struct PulseConfig : Sendable {
    public var minLevel: PulseLevel = .debug
    public var environment: String = "production"
    public var maxQueueSize: Int = 256
    /// Enables debug-only sinks (e.g. event name linter). Pass the host app's debug flag:
    /// a prebuilt release XCFramework cannot know whether the app itself is a debug build.
    public var debugMode: Bool = false
        public init() {}
}
