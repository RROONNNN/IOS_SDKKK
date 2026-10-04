public enum PulseLevel: Int, Sendable, Comparable {
    case verbose = 2
    case debug = 3
    case info = 4
    case warn = 5
    case error = 6

    public static func < (lhs: PulseLevel, rhs: PulseLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public var description: String {
         switch self {
         case .verbose: "VERBOSE"
         case .debug: "DEBUG"
         case .info: "INFO"
         case .warn: "WARN"
         case .error: "ERROR"
         }
     }
}
