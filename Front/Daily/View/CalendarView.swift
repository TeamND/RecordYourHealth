//
//  CalendarView.swift
//  Daily
//
//  Created by 최승용 on 3/9/24.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var userInfo: UserInfo
    @ObservedObject var userInfoViewModel: UserInfoViewModel
    @ObservedObject var calendarViewModel: CalendarViewModel
    @ObservedObject var navigationViewModel: NavigationViewModel
    @State private var popupInfo: PopupInfo = PopupInfo()
    
    var body: some View {
        VStack(spacing: 0) {
            MainHeader(userInfo: userInfo, calendarViewModel: calendarViewModel, navigationViewModel: navigationViewModel, popupInfo: popupInfo)
                .frame(height: 40)
            MainCalendar(userInfo: userInfo, calendarViewModel: calendarViewModel, navigationViewModel: navigationViewModel)
        }
    }
}

#Preview {
    CalendarView(userInfo: UserInfo(), userInfoViewModel: UserInfoViewModel(), calendarViewModel: CalendarViewModel(), navigationViewModel: NavigationViewModel())
}
