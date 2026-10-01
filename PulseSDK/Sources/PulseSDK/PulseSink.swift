public protocol PulseSink: Sendable {
    var id: String {get}
    func write(_ event: PulseEvent) throws
}
