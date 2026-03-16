# Implementation Plan

## Objective
Create a native macOS menu bar application to display multiple timezones (similar to Dato) for local, personal use.

## Scope & Constraints
- Platform: macOS 13.0+ (Requires modern SwiftUI `MenuBarExtra`).
- UI: Exclusively a menu bar app (no dock icon, no main window).
- Functionality: Displays the current time in the menu bar, clicking it reveals a list of configured timezones.
- Distribution: Local use only. Ad-hoc signing will be used so it runs locally.

## Key Files & Context
- `Sources/TimeApp/TimeApp.swift`: Main application entry point.
- `Sources/TimeApp/TimezoneManager.swift`: Logic for managing the timer and date formatting.
- `build.sh`: Bash script to compile Swift code into a `.app` bundle, inject `Info.plist`, and ad-hoc sign it.
- `Makefile`: Convenient targets for building, running, and cleaning the app.

## Implementation Steps
1. Create directory structure for `Sources/TimeApp`.
2. Implement SwiftUI Application in `TimeApp.swift`.
3. Implement `TimezoneManager.swift` to handle multiple timezones.
4. Write `build.sh` script to compile (`swiftc`), package (`TimeApp.app`), and sign the executable.
5. Create a `Makefile` with `all`, `run`, `clean`, and `stop` targets.
6. Build and Run: `make run`.

## Verification
- App launches without a dock icon.
- Menu bar item displays the primary time.
- Clicking the menu bar item shows a drop-down of other configured timezones.
- "Quit" terminates the app successfully.