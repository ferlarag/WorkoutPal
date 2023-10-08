//
//  ContentView.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var workouts: WorkoutsViewModel
    @EnvironmentObject var health: HealthKitViewModel
    @EnvironmentObject var timerVM: TimerViewModel

    var body: some View {
        NavigationStack(path: $workouts.presentedViews){
            SelectWorkoutView()
                .navigationTitle("Activities")
                .navigationDestination(for: CustomHKWorkoutActivityType.self) { _ in
                    SessionTabView()
                        .navigationBarBackButtonHidden()
                }
                .navigationDestination(for: TimerItem.self) { timer in
                    CountdownView()
                        .navigationBarBackButtonHidden()
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button{
                                    timerVM.end()
                                } label: {
                                    Label("Cancel", systemImage: "xmark")
                                }
                            }
                            ToolbarItem(placement: .bottomBar) {
                                Button{
                                    //toggle pause
                                    timerVM.togglePause()
                                } label: {
                                    Label("Toggle Pause", systemImage: timerVM.isRunning ? "pause" : "play")
                                }
                            }
                            ToolbarItem(placement: .bottomBar) {
                                Button{
                                    //Restart timer
                                    timerVM.restart()
                                } label: {
                                    Label("Repeat", systemImage: "arrow.counterclockwise")
                                }
                            }
                        }
                }
                .toolbar(health.selectedView == .nowPlaying ? .hidden : .visible, for: .navigationBar)
        }
        .sheet(isPresented: $health.showWorkoutSessionSummary) {
            WorkoutSessionSummaryView()
        }
        .onAppear{
            health.requestAuthorization()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WorkoutsViewModel.shared)
        .environmentObject(HealthKitViewModel.shared)
        .environmentObject(TimerViewModel.shared)
}
