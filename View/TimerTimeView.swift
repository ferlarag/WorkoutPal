//
//  TimerTimeView.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import SwiftUI

struct TimerTimeView: View {
    var elapsedTime: TimeInterval = 0
    var showSubseconds: Bool = false
    @State private var timeFormatter = TimerTimerFormatter()

    var body: some View {
        Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
            .fontWeight(.semibold)
            .onChange(of: showSubseconds, { oldValue, newValue in
                timeFormatter.showSubseconds = newValue
            })
    }
}

class TimerTimerFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    var showSubseconds = false

    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }

        guard let formattedString = componentsFormatter.string(from: time) else {
            return nil
        }

        if showSubseconds {
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            return String(format: "%@%@%0.2d", formattedString, decimalSeparator, hundredths)
        }

        return formattedString
    }
}

#Preview {
    TimerTimeView()
        .environmentObject(WorkoutsViewModel.shared)
        .environmentObject(HealthKitViewModel.shared)
}
