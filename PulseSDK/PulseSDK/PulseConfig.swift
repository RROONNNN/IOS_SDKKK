public struct PulseConfig : Sendable {
    public var minLevel: PulseLevel = .debug
    public var environment: String = "production"
    public var maxQueueSize: Int = 256
        public init() {}
}
