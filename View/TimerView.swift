//
//  TimerView.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        VStack{
            Spacer()
            TimePickerView()
        }
    }
}

struct TimePickerView: View {
    @EnvironmentObject var timer: TimerViewModel
    @EnvironmentObject var health: HealthKitViewModel
    @EnvironmentObject var workouts: WorkoutsViewModel

    var body: some View {
        VStack {
            VStack(spacing: 16){
                CustomTimePicker(minutes: $timer.minutes,
                                 seconds: $timer.seconds)
                Button("Start"){
                    health.showTimerPicker = false
                    let duration = (timer.minutes * 60) + timer.seconds
                    workouts.presentedViews.append(TimerItem(duration: duration))
                    timer.start()
                }
                .tint(.accent)
                .padding(.horizontal)
            }
        }
    }
}

struct CountdownView: View {
    @EnvironmentObject var workout: WorkoutsViewModel
    @EnvironmentObject var health: HealthKitViewModel
    @EnvironmentObject var timerVM: TimerViewModel

    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: timerVM.startDate ?? Date(), isPaused: timerVM.isRunning)) { context in
            ZStack{
                Circle()
                    .stroke(.accent, lineWidth: 10)
                    .opacity(0.25)
                Circle()
                    .trim(from: 0, to: timerVM.progress)
                    .stroke(.accent, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: timerVM.progress)
                TimerTimeView(elapsedTime: (timerVM.time ?? 0) - timerVM.elapsedTime, showSubseconds: false)
                    .font(.system(.title2, design: .rounded))
            }
        }
    }
}

#Preview{
    CountdownView()
        .environmentObject(WorkoutsViewModel.shared)
        .environmentObject(TimerViewModel.shared)
        .environmentObject(HealthKitViewModel.shared)
}

#Preview {
    TimerView()
        .environmentObject(WorkoutsViewModel.shared)
        .environmentObject(TimerViewModel.shared)
        .environmentObject(HealthKitViewModel.shared)
}

