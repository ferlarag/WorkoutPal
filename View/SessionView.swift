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

    var commonFont: Font {
        if health.activity!.activityType.supportsDistance {
            Font.system(size: 24, design: .rounded)
                .monospacedDigit()
                .lowercaseSmallCaps()
        } else {
            Font.system(size: 32, design: .rounded)
                .monospacedDigit()
                .lowercaseSmallCaps()
        }
    }

    var body: some View {
        TimelineView(MetricsTimelineSchedule(from: health.builder?.startDate ?? Date(), isPaused: health.session?.state == .paused)) { context in
            HStack{
                VStack(alignment: .leading){
                    ElapsedTimeView(
                        elapsedTime: health.builder?.elapsedTime ?? 0,
                        showSubseconds: context.cadence == .live
                    )
                    .fontWeight(.semibold)
                    .foregroundStyle(.accent)
                    .font(commonFont)


                    Text(Measurement(value: health.caloriesBurned, 
                                     unit: UnitEnergy.kilocalories)
                        .formatted(.measurement(width: .abbreviated,
                                                usage: .workout,
                                                numberFormatStyle: .number.precision(.fractionLength(0)))))
                    .font(commonFont)

                    Text(health.heartRate.formatted(.number.precision(.fractionLength(0))) + " Bpm")
                        .font(commonFont)

                    if health.activity!.showDistance {
                        Text(Measurement(value: health.distance, unit: UnitLength.kilometers).formatted(.measurement(width: .abbreviated, usage: .asProvided, numberFormatStyle: .number.precision(.fractionLength(2)))))
                            .font(commonFont)
                    }
                }
                .padding(.bottom)
                Spacer()
            }
        }
    }
}

#Preview {
    HealthKitViewModel.shared.activity = .functionalStrengthTraining
    return NavigationStack{
        SessionView()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button{

                    } label: {
                        Label("Text", systemImage: "timer")
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button{

                    } label: {
                        Label("Toggle Pause", systemImage: "pause")
                    }
                    .foregroundStyle(.white)
                }

                ToolbarItem(placement: .bottomBar) {
                    Button{

                    } label: {
                        Label("Activity", systemImage: "xmark")
                    }
                    .foregroundStyle(.accent)
                }

                ToolbarItem(placement: .bottomBar) {
                    Button{

                    } label: {
                        Label("Finish", systemImage: "checkmark")
                    }
                    .foregroundStyle(.accent)
                }
            }
    }
        .environmentObject(HealthKitViewModel.shared)
}
