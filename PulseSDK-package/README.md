PulseiOS/                          ← thư mục làm việc
├── PulseSDK/                      ← Swift Package (SDK)
│   ├── Package.swift
│   ├── Sources/PulseSDK/
│   │   ├── Pulse.swift            ← API public duy nhất (facade)
│   │   ├── PulseConfig.swift
│   │   ├── PulseEvent.swift
│   │   ├── PulseLevel.swift
│   │   ├── PulseSink.swift
│   │   ├── OSLogSink.swift
│   │   ├── Internal/
│   │   │   ├── PulseEngine.swift
│   │   │   ├── EngineHolder.swift
│   │   │   ├── DebugSinks.swift
│   │   │   └── InternalLog.swift
│   │   └── Resources/
│   │       └── PrivacyInfo.xcprivacy
│   └── Tests/PulseSDKTests/
│       └── PulseSDKTests.swift
└── PulseDemo/                     ← Xcode project (app)
    └── PulseDemo/
        ├── PulseDemoApp.swift
        ├── ContentView.swift
        └── DemoSinks.swift//

