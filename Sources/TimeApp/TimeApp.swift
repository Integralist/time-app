import SwiftUI

@main
struct TimeApp: App {
    @StateObject private var tzManager = TimezoneManager()

    var body: some Scene {
        MenuBarExtra {
            // Dropdown menu content
            ForEach(tzManager.timezones) { tz in
                // Using a Toggle natively provides a checkmark in the menu 
                // and renders the text brightly (as an active control) rather than faded
                Toggle(isOn: Binding(
                    get: { tzManager.pinnedIdentifiers.contains(tz.identifier) },
                    set: { _ in tzManager.togglePin(for: tz.identifier) }
                )) {
                    Text("\(tz.flag) \(tz.name)\t\(tzManager.formatTime(for: tz.timeZone, date: tzManager.currentTime))")
                }
            }
            
            Divider()
            
            Button("Quit TimeApp") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q", modifiers: [.command])
        } label: {
            // The label appears in the Menu Bar itself
            Text(tzManager.menuBarText(date: tzManager.currentTime))
                .monospacedDigit()
        }
    }
}