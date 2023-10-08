//
//  Worktout_PalsApp.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI

@main
struct Worktout_Pals_Watch_AppApp: App {
    @StateObject var workouts = WorkoutsViewModel.shared
    @StateObject var health = HealthKitViewModel.shared
    @StateObject var timer = TimerViewModel.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(workouts)
                .environmentObject(health)
                .environmentObject(timer)
        }
    }
}
