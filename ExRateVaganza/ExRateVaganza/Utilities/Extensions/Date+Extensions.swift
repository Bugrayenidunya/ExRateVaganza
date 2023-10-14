//
//  Date+Extensions.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 14.10.2023.
//

import Foundation

extension Date {
    /// Get last business day date as String in format of "yyyy-MM-dd"
    /// Timezone is euqal to "America/New_York"
    private static var getLastBusinessDay: Date {
        guard let timeZone = TimeZone(identifier: "America/New_York") else { return Date() }
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        var businessDay = Date()
        let currentWeekday = calendar.component(.weekday, from: businessDay)
        
        // Subtract days based on current weekday
        switch currentWeekday {
        case 1:
            businessDay = calendar.date(byAdding: .day, value: -2, to: businessDay) ?? Date()
        case 2:
            businessDay = calendar.date(byAdding: .day, value: -3, to: businessDay) ?? Date()
        case 7:
            businessDay = calendar.date(byAdding: .day, value: -1, to: businessDay) ?? Date()
        default:
            businessDay = calendar.date(byAdding: .day, value: -1, to: businessDay) ?? Date()
        }

        return businessDay
    }
    
    static var getOpeningHourTimeInterval: TimeInterval {
        guard let timeZone = TimeZone(identifier: "America/New_York") else { return TimeInterval() }
        var calendar = Calendar.current
        calendar.timeZone = timeZone

        var components = calendar.dateComponents([.year, .month, .day], from: getLastBusinessDay)
        components.hour = 9
        components.minute = 30
        components.second = 0

        if let openingTime = calendar.date(from: components)?.timeIntervalSince1970 {
            return TimeInterval(openingTime)
        }

        return TimeInterval()
    }
    
    static var getClosingTimeForDate: TimeInterval {
        guard let timeZone = TimeZone(identifier: "America/New_York") else { return TimeInterval() }
        var calendar = Calendar.current
        calendar.timeZone = timeZone

        var components = calendar.dateComponents([.year, .month, .day], from: getLastBusinessDay)
        components.hour = 16
        components.minute = 0
        components.second = 0

        if let closingTime = calendar.date(from: components)?.timeIntervalSince1970 {
            return TimeInterval(closingTime)
        }

        return TimeInterval()
    }
}
