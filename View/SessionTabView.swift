//
//  SessionTabView.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI
import WatchKit

struct SessionTabView: View {
    @EnvironmentObject var health: HealthKitViewModel
    var body: some View {
        TabView(selection: $health.selectedView)  {
            SessionView()
                .tabViewStyle(.carousel)
                .tabItem { Text("Session") }
                .tag(SessionMainNavigation.session)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button{
                            health.showTimerPicker.toggle()
                        } label: {
                            Label("Text", systemImage: "timer")
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            health.togglePause()
                        } label: {
                            Label("Toggle Pause", systemImage: health.session?.state == .paused ? "play" : "pause")
                        }
                        .foregroundStyle(.white)
                    }

                    ToolbarItem(placement: .bottomBar) {
                        Button{
                            health.showActivities.toggle()
                        } label: {
                            Label("Activity", systemImage: health.activity?.icon ?? "xmark")
                        }
                        .foregroundStyle(.accent)
                    }

                    ToolbarItem(placement: .bottomBar) {
                        Button{
                            health.finishWorkout()
                        } label: {
                            Label("Finish", systemImage: "checkmark")
                        }
                        .foregroundStyle(.accent)
                    }
                }
            NowPlayingView()
                .tabItem { Text("Now Playing") }
                .tag(SessionMainNavigation.nowPlaying)
        }
        .sheet(isPresented: $health.showTimerPicker){
            TimerView()
        }
        .sheet(isPresented: $health.showActivities){
            SelectWorkoutView()
                .navigationTitle("Activities")
        }
    }
}

#Preview {
    HealthKitViewModel.shared.activity = .runningOutdoors

    return SessionTabView()
        .environmentObject(WorkoutsViewModel.shared)
        .environmentObject(HealthKitViewModel.shared)
        .environmentObject(TimerViewModel.shared)
}
