import Foundation
import Combine

struct TimezoneItem: Identifiable {
    let id = UUID()
    let name: String
    let identifier: String
    let flag: String

    var timeZone: TimeZone {
        TimeZone(identifier: identifier) ?? TimeZone.current
    }
}

class TimezoneManager: ObservableObject {
    @Published var currentTime: Date = Date()
    @Published var pinnedIdentifiers: Set<String> = []
    private var timer: AnyCancellable?

    let timezones: [TimezoneItem] = [
        TimezoneItem(name: "Local", identifier: TimeZone.current.identifier, flag: "📍"),
        TimezoneItem(name: "US Pacific", identifier: "America/Los_Angeles", flag: "🇺🇸"),
        TimezoneItem(name: "US Central", identifier: "America/Chicago", flag: "🇺🇸"),
        TimezoneItem(name: "New York", identifier: "America/New_York", flag: "🇺🇸"),
        TimezoneItem(name: "UTC", identifier: "UTC", flag: "🌐"),
        TimezoneItem(name: "London", identifier: "Europe/London", flag: "🇬🇧"),
        TimezoneItem(name: "Tokyo", identifier: "Asia/Tokyo", flag: "🇯🇵"),
        TimezoneItem(name: "Sydney", identifier: "Australia/Sydney", flag: "🇦🇺")
    ]

    init() {
        // Update the time every second to keep the menu bar accurate
        timer = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] date in
                self?.currentTime = date
            }
    }

    func formatTime(for timezone: TimeZone, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.dateFormat = "EEE d MMM HH:mm:ss" // 24hr format
        return formatter.string(from: date)
    }

    func formatShortTime(for timezone: TimeZone, date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.dateFormat = "HH:mm" // 24hr format for menu bar
        return formatter.string(from: date)
    }

    func menuBarText(date: Date) -> String {
        // Base local time always shown
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE HH:mm:ss"
        let localStr = formatter.string(from: date)
        
        let localFlag = timezones.first(where: { $0.name == "Local" })?.flag ?? "📍"
        var parts = ["\(localFlag) \(localStr)"]
        
        // Append any pinned timezones
        for tz in timezones {
            if pinnedIdentifiers.contains(tz.identifier) {
                let timeStr = formatShortTime(for: tz.timeZone, date: date)
                parts.append("\(tz.flag) \(timeStr)")
            }
        }
        
        return parts.joined(separator: "  ")
    }
    
    func togglePin(for identifier: String) {
        if pinnedIdentifiers.contains(identifier) {
            pinnedIdentifiers.remove(identifier)
        } else {
            pinnedIdentifiers.insert(identifier)
        }
    }
}