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

                VStack(alignment: .leading){
                    HStack{
                        ElapsedTimeView(
                            elapsedTime: health.builder?.elapsedTime ?? 0,
                            showSubseconds: context.cadence == .live
                        )
                        .foregroundStyle(.accent)
                        .font(.system(size: 500, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                                .minimumScaleFactor(0.01)
                        Spacer()
                    }

                    Text(Measurement(value: health.caloriesBurned, unit: UnitEnergy.kilocalories).formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                        .font(.system(size: 500, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                                .minimumScaleFactor(0.01)

                    Text(health.heartRate.formatted(.number.precision(.fractionLength(0))) + " BPM")
                        .font(.system(size: 500, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                                .minimumScaleFactor(0.01)

                    if health.activity!.showDistance {
                        Text(Measurement(value: health.distance, unit: UnitLength.kilometers).formatted(.measurement(width: .abbreviated, usage: .asProvided, numberFormatStyle: .number.precision(.fractionLength(2)))))
                            .font(.system(size: 500, design: .rounded).monospacedDigit().lowercaseSmallCaps())
                                    .minimumScaleFactor(0.01)
                    }
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
