//
//  DailyCycleTypePicker.swift
//  Daily
//
//  Created by seungyooooong on 10/28/24.
//

import SwiftUI

struct DailyCycleTypePicker: View {
    @Binding var cycleType: CycleTypes
    
    var body: some View {
        Menu {
            ForEach(CycleTypes.allCases, id: \.self) { cycleType in
                Button {
                    withAnimation {
                        self.cycleType = cycleType
                    }
                } label: {
                    Text(cycleType.text)
                }
            }
        } label: {
            Text(cycleType.text)
                .font(.system(size: CGFloat.fontSize * 2.5))
                .foregroundStyle(Colors.daily)
        }
    }
}

#Preview {
    DailyCycleTypePicker(cycleType: .constant(.date))
}
