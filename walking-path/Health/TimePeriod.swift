//
//  TimePeriod.swift
//  walking-path
//
//  Created by student on 2024/08/27.
//

import Foundation

enum TimePeriod {
    case day, week, month, year
}

func dateRange(for period: TimePeriod) -> (startDate: Date, endDate: Date) {
    let calendar = Calendar.current
    let now = Date()
    
    switch period {
    case .day:
        let startOfDay = calendar.startOfDay(for: now)
        return (startOfDay, now)
        
    case .week:
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
        return (startOfWeek, now)
        
    case .month:
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
        return (startOfMonth, now)
        
    case .year:
        let startOfYear = calendar.date(from: calendar.dateComponents([.year], from: now))!
        return (startOfYear, now)
    }
}
