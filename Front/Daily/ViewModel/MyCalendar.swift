//
//  Calendar.swift
//  Daily
//
//  Created by 최승용 on 2022/11/08.
//

import Foundation

class MyCalendar: ObservableObject {
    @Published var showMonth: Bool
    @Published var showWeekDay: Bool
    @Published var year: Int
    @Published var month: Int
    @Published var day: Int
    var startDayIndex: Int = 0
    var lengthOfMonth: Int = 31
    
    init() {
        self.showMonth = true
        self.showWeekDay = false
        
        self.year = Date().year
        self.month = Date().month
        self.day = Date().day
    }
    
    func setState(state: String = "Month") {
        switch state {
        case "Year":
            self.showMonth = false
            self.showWeekDay = false
        case "Month":
            self.startDayIndex = "\(String(self.year))-\(String(format: "%02d", self.month))-01".toDate()!.startDayIndex()
            self.lengthOfMonth = "\(String(self.year))-\(String(format: "%02d", self.month))-01".toDate()!.lastDayOfMonth().day
            self.showMonth = true
            self.showWeekDay = false
        case "Week&Day":
            self.showMonth = true
            self.showWeekDay = true
        default:
            print("error")
            print("state is \(state)")
        }
    }
    
    func isToday(day: Int) -> Bool {
        let today = Date()
        if today.year == self.year && today.month == self.month {
            return today.day == day
        }
        return false
    }
}
