//
//  HealthKitViewModel.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import Foundation
import HealthKit
import SwiftUI

class HealthKitViewModel: NSObject, ObservableObject {
    static let shared = HealthKitViewModel()

    @Published var selectedView: SessionMainNavigation = .session

    let healthStore = HKHealthStore()

    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    @Published var activity: CustomHKWorkoutActivityType? {
        didSet{
            guard let activity = activity else { return }
            if !isWorkoutSessionRunning {
                recordedWorkouts = []
                isWorkoutSessionRunning = true
                startActivity(activity)
            } else {
                nextActivity = activity
            }
        }
    }

    @Published var nextActivity: CustomHKWorkoutActivityType? {
        didSet {
            guard nextActivity != nil else { return }
            self.end()
        }
    }
    @Published var isWorkoutSessionRunning = false {
        didSet {
            if !isWorkoutSessionRunning {
                DispatchQueue.main.async {
                    self.showWorkoutSessionSummary = true
                }
            }
        }
    }
    @Published var showWorkoutSessionSummary = false {
        didSet {
            if !showWorkoutSessionSummary {
                self.clearState()
            }
        }
    }
    @Published var showTimerPicker = false
    @Published var showActivities = false

    @Published var heartRate: Double = 0
    @Published var averageHeartRate: Double = 0
    @Published var caloriesBurned: Double = 0
    @Published var distance: Double = 0

    //check out the HKWorkoutSessionDelegate
    @Published var recordedWorkouts: [HKWorkout] = []

    func requestAuthorization(){
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .distanceSwimming)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWheelchair)!,
            HKQuantityType.activitySummaryType()
        ]

        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in }
    }

    func startActivity(_ activity: CustomHKWorkoutActivityType){
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = activity.activityType

        if activity != .swimming {
            configuration.locationType = activity.locationType
        } else {
            configuration.swimmingLocationType = activity.swimLocationType
        }

        do{
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        } catch let error {
            print(error.localizedDescription)
            return
        }

        session?.delegate = self
        builder?.delegate = self
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)

        let date = Date()
        session?.startActivity(with: date)
        builder?.beginCollection(withStart: date){ success, error in
            if success {
                print("Everything should start properly")
                WKInterfaceDevice.current().play(.start)
            } else {
                print(error?.localizedDescription ?? "An error occurred trying to start the session")
                WKInterfaceDevice.current().play(.failure)
            }
        }
    }

    func togglePause(){
        if session?.state == .running {
            self.pause()
        } else {
            self.resume()
        }
    }

    func pause(){
        session?.pause()
    }

    func resume(){
        session?.resume()
    }

    func end(){
        session?.end()
    }

    func finishWorkout(){
        end()
        nextActivity = nil
    }

    func clearState(){
        session = nil
        builder = nil

        DispatchQueue.main.async {
            self.heartRate = 0
            self.averageHeartRate = 0
            self.caloriesBurned = 0
            self.distance = 0
        }
    }

    func updateStatistic(_ statistics: HKStatistics?){
        guard let statistics = statistics else { return }
        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                self.caloriesBurned = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning), HKQuantityType.quantityType(forIdentifier: .distanceCycling), HKQuantityType.quantityType(forIdentifier: .distanceWheelchair), HKQuantityType.quantityType(forIdentifier: .distanceSwimming):
                let meterUnit = HKUnit.meter()
                self.distance = (statistics.sumQuantity()?.doubleValue(for: meterUnit) ?? 0) / 1000
            default:
                return
            }
        }
    }
}

extension HealthKitViewModel: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
//        DispatchQueue.main.async {
//            switch toState {
//            case .ended:
//                print("Ended")
//            case .running:
//                print("Running")
//            case .paused:
//                print("Paused")
//            default:
//                print("Other")
//            }
//        }

        //end the data collection here
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                self.builder?.finishWorkout{ (workout, err) in
                    self.recordedWorkouts.append(workout!)
                    self.clearState()

                    //start new activity or finish workout session
                    if self.nextActivity != nil {
                        self.startActivity(self.nextActivity!)
                    } else {
                        DispatchQueue.main.async{
                            WorkoutsViewModel.shared.presentedViews.removeLast()
                            self.isWorkoutSessionRunning = false
                        }
                    }
                }
            }
        }
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("WorkoutSessionDelegate: " + error.localizedDescription)
    }
}

//MARK: - HKLiveWorkoutBuilderDelegate
extension HealthKitViewModel: HKLiveWorkoutBuilderDelegate {
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return // Nothing to do.
            }

            let statistics = workoutBuilder.statistics(for: quantityType)

            // Update the published values.
            updateStatistic(statistics)
        }
    }

    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {

    }
}

