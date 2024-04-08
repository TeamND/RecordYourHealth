//
//  RecordView.swift
//  Daily
//
//  Created by 최승용 on 3/9/24.
//

import SwiftUI

struct RecordView: View {
    @ObservedObject var userInfo: UserInfo
    @ObservedObject var navigationViewModel: NavigationViewModel
    @State var goalModel: GoalModel = GoalModel()
    @State var date: Date = Date()
    @State var isShowCalendarSheet: Bool = false
    @State var isShowSymbolSheet: Bool = false
    @State var isShowContentLengthAlert: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    Label {
                        Text("\(userInfo.currentYearLabel) \(userInfo.currentMonthLabel) \(userInfo.currentDayLabel) \(userInfo.currentDOW)요일")
                    } icon: {
                        Image(systemName: "calendar")
                    }
                }
                .onTapGesture {
                    isShowCalendarSheet = true
                }
                .sheet(isPresented: $isShowCalendarSheet) {
                    CalendarSheet(userInfo: userInfo, date: $date)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
                Spacer()
                Group {
                    Image(systemName: "\(goalModel.symbol.toSymbol()!.rawValue)")
                        .padding()
                    Image(systemName: "chevron.right")
                    Image(systemName: "\(goalModel.symbol.toSymbol()!.rawValue).fill")
                        .padding()
                }
                .onTapGesture {
                    isShowSymbolSheet = true
                }
                .sheet(isPresented: $isShowSymbolSheet) {
                    SymbolSheet(symbol: $goalModel.symbol)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }
            .frame(height: 40)
            
            TextField(
                "",
                text: $goalModel.content,
                prompt: Text("아침 7시 기상")
            )
            .padding()
            .background(Color("BackgroundColor"))
            .cornerRadius(5.0)
            
            HStack {
                Spacer()
                Button {
                    goalModel.symbol = "체크"
                    goalModel.content = ""
                    date = Date()
                    userInfo.currentYear = date.year
                    userInfo.currentMonth = date.month
                    userInfo.currentDay = date.day
                } label: {
                    Text("Reset")
                }
                Button {
                    if goalModel.content.count < 2 {
                        isShowContentLengthAlert = true
                    } else {
                        let currentDate = userInfo.currentYearStr + userInfo.currentMonthStr + userInfo.currentDayStr
                        goalModel.user_uid = userInfo.uid
                        goalModel.start_date = currentDate
                        goalModel.end_date = currentDate
                        goalModel.cycle_date = [currentDate]
                        addGoal(goal: goalModel) { data in
                            if data.code == "00" {
                                goalModel.symbol = "체크"
                                goalModel.content = ""
                                navigationViewModel.setTagIndex(tagIndex: 0)
                            }
                        }
                    }
                } label: {
                    Text("Add")
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .alert(isPresented: $isShowContentLengthAlert, content: {
            Alert(
                title: Text("목표의 길이가 너무 짧습니다."),
                message: Text("최소 2글자 이상의 목표를 설정해주세요."),
                dismissButton: .default(
                    Text("확인")
                )
            )
        })
    }
}

#Preview {
    RecordView(userInfo: UserInfo(), navigationViewModel: NavigationViewModel())
}
