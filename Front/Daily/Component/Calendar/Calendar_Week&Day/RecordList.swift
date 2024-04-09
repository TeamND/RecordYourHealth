//
//  RecordList.swift
//  Daily
//
//  Created by 최승용 on 3/31/24.
//

import SwiftUI

struct RecordList: View {
    @ObservedObject var userInfo: UserInfo
    @ObservedObject var navigationViewModel: NavigationViewModel
    @ObservedObject var calendarViewModel: CalendarViewModel
    
    var body: some View {
        VStack {
            ForEach ($calendarViewModel.recordsOnWeek, id:\.self.uid) { record in
                RecordOnList(userInfo: userInfo, calendarViewModel: calendarViewModel, record: record)
                    .contextMenu {
                        NavigationLink {
                            ModifyDateView(userInfo: userInfo, record: record)
                        } label: {
                            Label("날짜 변경", systemImage: "calendar")
                        }
                        NavigationLink {
                            ModifyGoalView(userInfo: userInfo, navigationViewModel: navigationViewModel, record: record, modifyGoalModel: modifyGoalModel(record: record.wrappedValue))
                        } label: {
                            Label("목표 수정", systemImage: "pencil")
                        }
                        Button {
                            deleteGoal(goalUID: String(record.goal_uid.wrappedValue)) { data in
                                if data.code == "00" {
                                    getCalendarWeek(userID: String(userInfo.uid), startDay: userInfo.calcStartDay(value: -userInfo.DOWIndex)) { (data) in
                                        calendarViewModel.setRatingOnWeek(ratingOnWeek: data.data.rating)
                                    }
                                    getCalendarDay(userID: String(userInfo.uid), day: "\(userInfo.currentYearStr)-\(userInfo.currentMonthStr)-\(userInfo.currentDayStr)") { (data) in
                                        calendarViewModel.setRecordsOnWeek(recordsOnWeek: data.data.goalList)
                                    }
                                } else { print("\(record.goal_uid) delete fail@@@") }
                            }
                        } label: {
                            Label("목표 삭제", systemImage: "trash")
                        }
                    }
                    .foregroundStyle(.primary)
            }
        }
    }
}
