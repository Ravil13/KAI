//
//  CurrentDay.swift
//  KAI_v2
//
//  Created by Ravil Vildanov on 07.01.2020.
//  Copyright © 2020 Ravil Vildanov. All rights reserved.
//

import Foundation


struct CurrentDay {
    
    private static let calendar = Calendar(identifier: .gregorian)
    private static let today = Date()
    
    
    private static var isCurrentSemesterFirst: Bool {
        return self.calendar.component(.month, from: self.today) > 8
    }
    
    static var isWeekEven: Bool {
        let firstDayOfSemester = DateComponents(
            calendar: self.calendar,
            year: self.calendar.component(.year, from: self.today),
            month: self.isCurrentSemesterFirst ? 9 : 1,
            day: self.isCurrentSemesterFirst ? 1 : 26
        ).date!
        
        let firstWeekOfSemester = self.calendar.component(.weekOfYear, from: firstDayOfSemester)
        let currentWeekOfYear = self.calendar.component(.weekOfYear, from: self.today) - (self.weekday == 7 ? 1 : 0)
        
        return currentWeekOfYear % 2 != firstWeekOfSemester % 2
    }
    
    static var weekType: WeekType {
        isWeekEven ? .even : .odd
    }
    
    static var nextWeekType: WeekType {
        isWeekEven ? .odd : .even
    }
    
    private static var weekday: Int {
        let weekday = self.calendar.component(.weekday, from: self.today) - 1
        return weekday == 0 ? 7 : weekday
    }
    
    static func stringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: Date())
    }
}
