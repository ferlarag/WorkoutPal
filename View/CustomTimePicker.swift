//
//  CustomTimePicker.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI

struct CustomTimePicker: View {

    private enum Focus: Hashable{
        case minutes, seconds
    }

    @Binding var minutes: Double
    @Binding var seconds: Double
    @FocusState private var focus: Focus?

    var formattedMinutes: String {
        let totalMinutes = Int(minutes)
        let minutes = totalMinutes % 60
        return String(format: "%02d", minutes)
    }

    var formattedSeconds: String {
        let totalSeconds = Int(seconds)
        let seconds = totalSeconds % 60
        return String(format: "%02d", seconds)
    }

    var body: some View {
        VStack{
            HStack(alignment: .center) {
                Text(formattedMinutes)
                    .foregroundStyle(focus == .minutes ? .accent : .white)
                    .focusable()
                    .focused($focus, equals: .minutes)
                    .onTapGesture {
                        focus = .minutes
                    }
                    .digitalCrownRotation($minutes,
                                          from: 0,
                                          through: 59,
                                          by: 1,
                                          sensitivity: .medium,
                                      isContinuous: true)
                Text(":")
                    .baselineOffset(8)
                Text(formattedSeconds)
                    .foregroundStyle(focus == .seconds ? .accent : .white)
                    .focusable()
                    .focused($focus, equals: .seconds)
                    .onTapGesture {
                        focus = .seconds
                    }
                    .digitalCrownRotation($seconds,
                                          from: 0,
                                          through: 59,
                                          by: 1,
                                          sensitivity: .medium,
                                          isContinuous: true)
            }
            .frame(height: 36)
            .font(.system(size:48 , weight: .semibold, design: .rounded))
            HStack{
                Spacer()
                Text("Mins")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Spacer()
                Text("Secs")
                    .font(.footnote)
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
    }
}

#Preview {
    CustomTimePicker(minutes: .constant(1), seconds: .constant(12))
}
