//
//  WeekOnMonth.swift
//  Daily
//
//  Created by 최승용 on 3/24/24.
//

import SwiftUI

struct WeekOnMonth: View {
    @ObservedObject var calendarViewModel: CalendarViewModel
    let rowIndex: Int
    let startDayIndex: Int
    let lengthOfMonth: Int
    @State var updateVersion: Bool = false
    var body: some View {
        HStack(spacing: 0) {
            ForEach (0..<7) { colIndex in
                let day: Int = rowIndex * 7 + colIndex - startDayIndex + 1
                if 1 <= day && day <= lengthOfMonth {
                    if updateVersion {
                        NavigationLink(value: "day_\(day)") {
                            DayOnMonth(calendarViewModel: calendarViewModel, day: day, dayOnMonth: calendarViewModel.getDaysOnMonth(dayIndex: day-1))
                        }
                    } else {
                        Button {
                            withAnimation {
                                calendarViewModel.setCurrentDay(day: day)
                                calendarViewModel.currentState = "week"
                            }
                        } label: {
                            DayOnMonth(calendarViewModel: calendarViewModel, day: day, dayOnMonth: calendarViewModel.getDaysOnMonth(dayIndex: day-1))
                        }
                    }
                } else {
                    DayOnMonth(calendarViewModel: calendarViewModel, day: 0, dayOnMonth: dayOnMonthModel())
                        .opacity(0)
                }
            }
        }
    }
}
