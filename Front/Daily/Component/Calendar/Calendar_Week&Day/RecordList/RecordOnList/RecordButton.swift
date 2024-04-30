//
//  RecordButton.swift
//  Daily
//
//  Created by 최승용 on 2022/11/15.
//

import SwiftUI

struct RecordButton: View {
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    @ObservedObject var calendarViewModel: CalendarViewModel
    @Binding var record: RecordModel
    @Binding var isBeforeRecord: Bool
    @State var isAction = false
    
    var body: some View {
        if isBeforeRecord {
            RecordProgressBar(record: $record, color: .primary)
        } else {
            Button {
                if record.issuccess {
                    isAction = true
                } else {
                    switch record.type {
                    case "check", "count":
                        increaseCount(recordUID: String(record.uid)) { (data) in
                            if data.code == "00" {
                                calendarViewModel.changeCalendar(amount: 0, userInfoViewModel: userInfoViewModel)
                            }
                        }
                    case "timer":
                        print("timer record button press")
                        //                    record.itart.toggle()
                    default:
                        print("catch error is record button")
                    }
                }
            } label: {
                ZStack {
                    RecordProgressBar(record: $record, color: Color("CustomColor"))
                    Image(systemName: "hand.thumbsup.circle")
                        .font(.system(size: CGFloat.fontSize * 4))
                        .background(Color("BackgroundColor"))
                        .cornerRadius(15)
                        .foregroundColor(Color("CustomColor"))
                        .scaleEffect(isAction ? 1 : 0)
                        .animation(.bouncy, value: 5)
                }
                .onChange(of: isAction) { newValue in
                    if isAction == true {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                            withAnimation {
                                isAction = false
                            }
                        }
                    }
                }
            }
        }
    }
}
