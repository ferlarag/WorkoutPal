//
//  TimerViewModel.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import Foundation
import WatchKit

class TimerViewModel: ObservableObject {
    static let shared = TimerViewModel()

    @Published var isRunning = false
    @Published var startDate: Date?
    @Published var timer: Timer?

    @Published var minutes: Double = 0
    @Published var seconds: Double = 0

    @Published var time: TimeInterval? {
        didSet {
            startDate = Date()
        }
    }

    @Published var elapsedTime: TimeInterval = 0 {
        didSet {
            if elapsedTime >= time ?? 0 {
                self.end()
            }
        }
    }

    var selectedTime: Double  {
        return (minutes * 60) + seconds
    }

    var progress: Double {
        return elapsedTime / (time ?? 0)
    }

    func togglePause(){
        isRunning.toggle()
    }

    func start(){
        let totalTime = TimeInterval((minutes * 60) + seconds)

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.isRunning {
                self.elapsedTime += 1
                let remainingTime = (self.time ?? 0) - self.elapsedTime
                if remainingTime < 31 && remainingTime > 5 && remainingTime.truncatingRemainder(dividingBy: 5) == 0 {
                    WKInterfaceDevice.current().play(.click)
                } else if remainingTime < 6 && remainingTime.truncatingRemainder(dividingBy: 1) == 0 {
                    WKInterfaceDevice.current().play(.click)
                }
            }
        }

        DispatchQueue.main.async {
            self.time = totalTime
            self.isRunning = true
        }
    }

    func end(){
        DispatchQueue.main.async {
            WorkoutsViewModel.shared.presentedViews.removeLast()
            self.timer?.invalidate()
            self.startDate = nil
            self.timer = nil
            self.isRunning = false
            self.elapsedTime = 0
            self.time = 0
            WKInterfaceDevice.current().play(.stop)
        }
    }

    func restart(){
        self.timer?.invalidate()
        self.startDate = nil
        self.timer = nil
        self.isRunning = false
        self.elapsedTime = 0
        self.time = 0
        start()
    }
}

