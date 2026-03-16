# TimeApp

🤖 **Note:** This entire application, including this README, was generated entirely by AI (Google Gemini) based on user prompts.

A lightweight, native macOS menu bar application designed to display your local time alongside multiple configurable timezones. Inspired by apps like [Dato](https://sindresorhus.com/dato), but built completely without an Xcode project or a paid Apple Developer account. 

It compiles entirely via the command line using standard Swift tools and ad-hoc signing to run beautifully on your local machine.

## Features

- **Native macOS UI:** Uses modern SwiftUI `MenuBarExtra` for a seamless menu bar experience.
- **24-Hour Format & Seconds:** Menu bar always shows local time with seconds ticking in real-time.
- **Multiple Timezones:** Includes US Pacific, US Central, New York, UTC, London, Tokyo, and Sydney out of the box.
- **Visual Flags:** Each timezone includes its respective country/region emoji flag for quick reading.
- **Menu Bar Pinning:** Click any timezone in the dropdown to instantly pin/unpin it directly to your top menu bar!
- **Invisible Footprint:** Runs completely in the background without cluttering your Dock (utilizes `LSUIElement`).

## Requirements

- **macOS 13.0+** (Required for modern SwiftUI `MenuBarExtra` support)
- **Xcode Command Line Tools** (For the `swiftc` compiler)

## Installation & Usage

This project uses a simple Bash script wrapped in a `Makefile` to compile the Swift source files directly into a valid `.app` bundle, inject the required `Info.plist`, and apply a local ad-hoc code signature.

1. **Build and Run:**
   ```bash
   make run
   ```
   *This will compile the app, kill any existing instances, and launch it. Check your top-right menu bar!*

2. **Launch on Startup (macOS):**
   ```bash
   make install
   ```
   *This builds the app and dynamically generates a `launchd` plist (`com.local.TimeApp.plist`) using the current directory's absolute path. It then registers it with macOS so that TimeApp automatically starts whenever you log in.* 
   *If you move the project folder, you must run `make uninstall` and then `make install` in the new location to update the path.*
   *To remove it from startup completely, run `make uninstall`.*

3. **Stop the App:**
   ```bash
   make stop
   ```
   *Alternatively, click the menu bar item and select "Quit TimeApp".*

4. **Clean the Build:**
   ```bash
   make clean
   ```

## Modifying Timezones

To add, remove, or modify timezones, simply open `Sources/TimeApp/TimezoneManager.swift` and edit the `timezones` array inside the `TimezoneManager` class. Re-run `make run` to see your changes instantly.
