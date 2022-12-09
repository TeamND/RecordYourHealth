//
//  WeekOnMonth.swift
//  Daily
//
//  Created by 최승용 on 2022/11/21.
//

import SwiftUI

struct WeekOnMonth: View {
    @StateObject var calendar: MyCalendar
    let rowIndex: Int
    var body: some View {
        HStack {
            ForEach (0..<7) { colIndex in
                let day: Int = rowIndex * 7 + colIndex - calendar.startDayIndex + 1
                if 1 <= day && day <= calendar.lengthOfMonth {
                    Button {
                        calendar.day = day
                        calendar.setState(state: "Week&Day")
                    } label: {
                        DayOnMonth(day: day)
                            .padding(4)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.green, lineWidth: 2)
                                    .opacity(calendar.isToday(day: day) ? 1 : 0)
                            }
                            .accentColor(.black)
                    }
                } else {
                    DayOnMonth(day: day)
                        .padding(4)
                        .opacity(0)
                }
            }
        }
    }
}
