//
//  WorkoutSessionSummaryView.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI
import HealthKit

struct WorkoutSessionSummaryView: View {
    @EnvironmentObject var health: HealthKitViewModel

    var body: some View {
        ScrollView {
            if health.recordedWorkouts.isEmpty {
                Text("Workout is loading")
            } else {
                VStack{
                    ForEach(health.recordedWorkouts, id: \.self){ workout in
                        SummaryViewItem(workout: workout)
                    }
                    HStack {
                        VStack(alignment: .leading){
                            Text("Activity Rings")
                                .font(.system(.footnote, design: .rounded))
                                .foregroundStyle(.gray)
                            ActivityRingsView(healthStore: health.healthStore)
                                .frame(width: 50, height: 50)
                        }
                        Spacer()
                    }
                }
                .scenePadding()
            }
        }
    }
}

private struct SummaryViewItem: View {
    @Environment(\.locale) var locale
    @EnvironmentObject var health: HealthKitViewModel
    var workout: HKWorkout
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    @State private var measurementFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            ActivityIcon(activityType: workout.workoutActivityType)

            SummaryMetricView(title: "Total Time",
                              value: durationFormatter.string(from: workout.duration) ?? "")
            .fontWeight(.medium)
                .foregroundStyle(.accent)
            if workout.workoutActivityType.supportsDistance {
                let distanceInMeters = workout.totalDistance?.doubleValue(for: .meter()) ?? 0
                var preferredUnit: UnitLength {
                    if locale.measurementSystem == .metric {
                        return .kilometers
                    } else {
                        return .miles
                    }
                }
                let convertedDistance = convertDistance(distanceInMeters, to: preferredUnit)

                SummaryMetricView(title: "Total Distance", value: measurementFormatter.string(from: convertedDistance))
                    .foregroundStyle(.pink)
            }

            SummaryMetricView(title: "Total Energy",
                              value: Measurement(value: workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0, unit: UnitEnergy.kilocalories)
                                .formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
            .foregroundStyle(.pink)
        }
    }

    private func convertDistance(_ distanceInMeters: Double, to unit: UnitLength) -> Measurement<UnitLength> {
        let distance = Measurement(value: distanceInMeters, unit: UnitLength.meters)
        return distance.converted(to: unit)
    }

}

private struct SummaryMetricView: View {
    var title: String
    var value: String

    var body: some View {
        Text(title)
            .font(.system(.footnote, design: .rounded))
            .foregroundStyle(.gray)
        Text(value)
            .font(.system(.title2, design: .rounded).lowercaseSmallCaps())
        Divider()
    }
}

private struct ActivityIcon: View {
    var activityType: HKWorkoutActivityType
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 40, height: 40)
                .foregroundStyle(.accent)
                .opacity(0.35)
            Image(systemName: activityType.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundStyle(.accent)
        }
        .padding(.bottom)
    }
}

#Preview {
    let workout_A = HKWorkout(activityType: .running,
                              start: Date(),
                              end: Date().addingTimeInterval(400),
                              duration: 400,
                              totalEnergyBurned: HKQuantity(unit: .kilocalorie(),
                                                            doubleValue: 320),
                              totalDistance: HKQuantity(unit: .meter(),
                                                        doubleValue: 432),
                              device: .local(), metadata: nil)

    HealthKitViewModel.shared.recordedWorkouts.append(workout_A)
    return WorkoutSessionSummaryView()
        .environmentObject(HealthKitViewModel.shared)
}

#Preview {
    ActivityIcon(activityType: .archery)
}
