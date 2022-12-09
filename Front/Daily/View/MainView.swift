//
//  MainView.swift
//  Daily
//
//  Created by 최승용 on 2022/11/05.
//

import SwiftUI

struct MainView: View {
    @State private var calendar: MyCalendar = MyCalendar()
    @State private var popupInfo: PopupInfo = PopupInfo()
    var body: some View {
        ZStack {
            MainCalendar(calendar: calendar)
            MainHeader(popupInfo: popupInfo)
            Popup(popupInfo: popupInfo)
        }
        .accentColor(.mint)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
