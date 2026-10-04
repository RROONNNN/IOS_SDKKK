#!/usr/bin/env bash
# Build PulseSDK.xcframework (iOS device + iOS Simulator).
set -euo pipefail
cd "$(dirname "$0")"

PROJECT="PulseSDK.xcodeproj"
SCHEME="PulseSDK"
BUILD_DIR="$(pwd)/build"

rm -rf "$BUILD_DIR"

for DESTINATION in "generic/platform=iOS" "generic/platform=iOS Simulator"; do
  NAME=$([ "$DESTINATION" = "generic/platform=iOS" ] && echo "iOS" || echo "iOS-Simulator")
  echo "▶ Archive $NAME"
  xcodebuild archive \
    -project "$PROJECT" \
    -scheme "$SCHEME" \
    -destination "$DESTINATION" \
    -archivePath "$BUILD_DIR/PulseSDK-$NAME" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES
done

echo "▶ Create XCFramework"
xcodebuild -create-xcframework \
  -archive "$BUILD_DIR/PulseSDK-iOS.xcarchive"           -framework PulseSDK.framework \
  -archive "$BUILD_DIR/PulseSDK-iOS-Simulator.xcarchive" -framework PulseSDK.framework \
  -output "$BUILD_DIR/PulseSDK.xcframework"

echo "✅ $BUILD_DIR/PulseSDK.xcframework"#

TH1:

client A -> SDK Mình

TH2:
client A -> library B -> SDK mình -> chưa 
