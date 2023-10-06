//
//  SelectWorkoutView.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI
import HealthKit

struct SelectWorkoutView: View {
    @EnvironmentObject var health: HealthKitViewModel
    @EnvironmentObject var workout: WorkoutsViewModel
    var body: some View {
        List{
            Section("Basics"){
                ForEach(CustomHKWorkoutActivityType.basicActivities, id: \.self){ activity in
                    SelectActivityButton(activity: activity)
                }
            }

            Section("Cardio"){
                ForEach(CustomHKWorkoutActivityType.cardioActivities, id: \.self){ activity in
                    SelectActivityButton(activity: activity)
                }
            }

            Section("Sports"){
                ForEach(CustomHKWorkoutActivityType.sportsActivities, id: \.self){ activity in
                    SelectActivityButton(activity: activity)
                }
            }

            Section("Warm-up & Cooldown"){
                ForEach(CustomHKWorkoutActivityType.warmupAndCooldownActivities, id: \.self){ activity in
                    SelectActivityButton(activity: activity)
                }
            }

            Section("Other"){
                ForEach(CustomHKWorkoutActivityType.mixedActivities, id: \.self){ activity in
                    SelectActivityButton(activity: activity)
                }
            }
        }
        .listStyle(.carousel)
    }
}

private struct SelectActivityButton: View {
    @EnvironmentObject var health: HealthKitViewModel
    @EnvironmentObject var workout: WorkoutsViewModel
    var activity: CustomHKWorkoutActivityType

    var body: some View {
        Button{
            //push a new view only if theres not a running workout
            if !health.isWorkoutSessionRunning {
                workout.presentedViews.append(activity)
            } else {
                health.showActivities = false
            }
            health.activity = activity
        } label: {
            HStack(spacing: 12){
                Image(systemName: activity.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.accent)
                Text(activity.name)
//                    .lineLimit(1)
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 4)
    }
}

#Preview {
    SelectWorkoutView()
        .environmentObject(HealthKitViewModel.shared)
        .environmentObject(WorkoutsViewModel.shared)
}

