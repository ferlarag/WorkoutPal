//
//  MetricsTimelineSchedule.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import Foundation
import SwiftUI

struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool

    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }

    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)

        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
