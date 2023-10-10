//
//  SessionView.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI
import HealthKit

struct SessionView: View {
    @EnvironmentObject var health: HealthKitViewModel
    @State private var sessionNav: SessionSecondaryNavigation = .metrics
    @State private var showTotalTime = true

    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: health.builder?.startDate ?? Date(), isPaused: health.session?.state == .paused)) { context in
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    ElapsedTimeView(
                        elapsedTime: health.builder?.elapsedTime ?? 0,
                        showSubseconds: context.cadence == .live
                    )
                    .foregroundStyle(.accent)
                    .font(.system(size: health.activity!.showDistance ? 24 : 32, design: .rounded).monospacedDigit().lowercaseSmallCaps())

                    Text(Measurement(value: health.caloriesBurned, unit: UnitEnergy.kilocalories).formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                        .font(.system(size: health.activity!.showDistance ? 24 : 32, design: .rounded).monospacedDigit().lowercaseSmallCaps())

                    Text(health.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                        .font(.system(size: health.activity!.showDistance ? 24 : 32, design: .rounded).monospacedDigit().lowercaseSmallCaps())

                    if health.activity!.showDistance {
                        Text(Measurement(value: health.distance, unit: UnitLength.kilometers).formatted(.measurement(width: .abbreviated, usage: .asProvided, numberFormatStyle: .number.precision(.fractionLength(2)))))
                            .font(.system(size: 24, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                    }
                }
                .padding(.bottom)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HealthKitViewModel.shared.activity = .gymnastics
    return SessionView()
        .environmentObject(HealthKitViewModel.shared)
}
