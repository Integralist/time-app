#!/bin/bash
set -e

APP_NAME="TimeApp"
APP_BUNDLE="${APP_NAME}.app"
CONTENTS_DIR="${APP_BUNDLE}/Contents"
MACOS_DIR="${CONTENTS_DIR}/MacOS"

echo "Building ${APP_NAME}..."

# Clean up any existing app bundle
rm -rf "$APP_BUNDLE"

# Create standard macOS App Bundle directory structure
mkdir -p "$MACOS_DIR"

# 1. Compile the Swift source files into the macOS binary
swiftc -parse-as-library \
    Sources/TimeApp/TimeApp.swift \
    Sources/TimeApp/TimezoneManager.swift \
    -o "$MACOS_DIR/$APP_NAME"

# 2. Generate the Info.plist file needed for macOS apps
# Key element here is LSUIElement=true, which completely hides the app from the Dock
cat > "$CONTENTS_DIR/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>${APP_NAME}</string>
    <key>CFBundleIdentifier</key>
    <string>com.local.${APP_NAME}</string>
    <key>CFBundleName</key>
    <string>${APP_NAME}</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
</dict>
</plist>
EOF

# 3. Apply an ad-hoc local signature to avoid security popups
codesign --force --deep --sign - "$APP_BUNDLE"

echo "Build complete: ${APP_BUNDLE}"