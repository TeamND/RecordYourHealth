//
//  Goal.swift
//  Daily
//
//  Created by 최승용 on 2022/11/14.
//

import SwiftUI

struct GoalOnList: View {
    @StateObject var goal: Goal
    var body: some View {
        ZStack {
            HStack(spacing: 12) {
//                Image(systemName: goal.symbol)
                if goal.symbol == "운동" { Image(systemName: "dumbbell.fill") }
                else { Image(systemName: "dumbbell") }
                Text(goal.content)
                Spacer()
                RecordButton(goal: goal)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(.mint)
            }
            .padding(.horizontal, 12)
            if goal.type != "check" {
                VStack {
                    Spacer()
//                    ProgressView(value: Double(goal.record_count), total: Double(goal.goal_count))
                    ProgressView(value: Double(0), total: Double(goal.goal_count))
                        .progressViewStyle(LinearProgressViewStyle(tint: .mint.opacity(0.8)))
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 12)
            }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.green, lineWidth: 2)
        }
    }
}
