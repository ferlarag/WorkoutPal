//
//  CustomHKWorkoutActivityType.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import Foundation
import HealthKit

enum CustomHKWorkoutActivityType {
    case boxing,
         cooldown,
         crossTraining,
         cyclingIndoor,
         cyclingOutdoor,
         elliptical,
         functionalStrengthTraining,
         gymnastics,
         handCycling,
         highIntensityIntervalTraining,
         hiking,
         jumpRope,
         kickboxing,
         martialArts,
         mindAndBody,
         mixedCardio,
         pilates,
         preparationAndRecovery,
         rowing,
         runningOutdoors,
         runningIndoors,
         stairs,
         stairClimbing,
         stepTraining,
         swimming,
         trackAndField,
         traditionalStrengthTraining,
         walkingIndoors,
         walkingOutdoors,
         wheelchairRunPace,
         wheelchairWalkPace,
         wrestling,
         yoga,
         other
}

extension CustomHKWorkoutActivityType: Identifiable {
    var id: Self { self }

    public static var basicActivities: [CustomHKWorkoutActivityType] {
        return [.runningIndoors, .runningOutdoors, .crossTraining, .functionalStrengthTraining, .swimming, .traditionalStrengthTraining, .highIntensityIntervalTraining, .cyclingIndoor, .cyclingOutdoor, .hiking, .walkingIndoors, .walkingOutdoors]
    }

    public static var cardioActivities: [CustomHKWorkoutActivityType] {
        return [.elliptical, .handCycling, .mixedCardio, .stairs, .stairClimbing, .stepTraining]
    }

    public static var sportsActivities: [CustomHKWorkoutActivityType] {
        return [.boxing, .gymnastics, .jumpRope, .kickboxing, .martialArts, .rowing, .trackAndField, .wrestling]
    }

    public static var warmupAndCooldownActivities: [CustomHKWorkoutActivityType] {
        return [.cooldown, .mindAndBody, .preparationAndRecovery]
    }

    public static var mixedActivities: [CustomHKWorkoutActivityType] {
        return [.pilates, .yoga, .wheelchairRunPace, .wheelchairWalkPace, .other]
    }

    var activityType: HKWorkoutActivityType {
        switch self {
        case .boxing:
            return HKWorkoutActivityType.boxing
        case .cooldown:
            return HKWorkoutActivityType.cooldown
        case .crossTraining:
            return HKWorkoutActivityType.crossTraining
        case .cyclingIndoor, .cyclingOutdoor:
            return HKWorkoutActivityType.cycling
        case .elliptical:
            return HKWorkoutActivityType.elliptical
        case .functionalStrengthTraining:
            return HKWorkoutActivityType.functionalStrengthTraining
        case .gymnastics:
            return HKWorkoutActivityType.gymnastics
        case .handCycling:
            return HKWorkoutActivityType.handCycling
        case .highIntensityIntervalTraining:
            return HKWorkoutActivityType.highIntensityIntervalTraining
        case .hiking:
            return HKWorkoutActivityType.hiking
        case .jumpRope:
            return HKWorkoutActivityType.jumpRope
        case .kickboxing:
            return HKWorkoutActivityType.kickboxing
        case .martialArts:
            return HKWorkoutActivityType.martialArts
        case .mindAndBody:
            return HKWorkoutActivityType.mindAndBody
        case .mixedCardio:
            return HKWorkoutActivityType.mixedCardio
        case .pilates:
            return HKWorkoutActivityType.pilates
        case .preparationAndRecovery:
            return HKWorkoutActivityType.preparationAndRecovery
        case .rowing:
            return HKWorkoutActivityType.rowing
        case .runningIndoors, .runningOutdoors:
            return HKWorkoutActivityType.running
        case .stairs:
            return HKWorkoutActivityType.stairs
        case .stairClimbing:
            return HKWorkoutActivityType.stairClimbing
        case .stepTraining:
            return HKWorkoutActivityType.stepTraining
        case .swimming:
            return HKWorkoutActivityType.swimming
        case .trackAndField:
            return HKWorkoutActivityType.trackAndField
        case .traditionalStrengthTraining:
            return HKWorkoutActivityType.traditionalStrengthTraining
        case .walkingIndoors, .walkingOutdoors:
            return HKWorkoutActivityType.walking
        case .wheelchairRunPace:
            return HKWorkoutActivityType.wheelchairRunPace
        case .wheelchairWalkPace:
            return HKWorkoutActivityType.wheelchairWalkPace
        case .wrestling:
            return HKWorkoutActivityType.wrestling
        case .yoga:
            return HKWorkoutActivityType.yoga
        default:
            return HKWorkoutActivityType.other
        }
    }

    var locationType: HKWorkoutSessionLocationType {
        switch self {
        case .cyclingOutdoor, .elliptical, .handCycling, .hiking, .rowing, .runningOutdoors, .trackAndField, .walkingOutdoors, .wheelchairRunPace, .wheelchairWalkPace :
            return .outdoor

        default:
            return .indoor
        }
    }

    var swimLocationType: HKWorkoutSwimmingLocationType {
        switch self {
        case .swimming:
            return .openWater

        default:
            return .unknown
        }
    }

    var showDistance: Bool {
        switch self {
        case .cyclingIndoor, .cyclingOutdoor, .elliptical, .handCycling, .hiking, .runningIndoors, .runningOutdoors, .stairs, .stepTraining, .swimming, .trackAndField, .walkingIndoors, .walkingOutdoors, .wheelchairRunPace, .wheelchairWalkPace:
            return true
        default:
            return false
        }
    }

    var name: String {
        switch self {
        case .boxing:
            return "Boxing"
        case .cooldown:
            return "Cooldown"
        case .crossTraining:
            return "Cross Training"
        case .cyclingIndoor:
            return "Indoor Cycling"
        case .cyclingOutdoor:
            return "Outdoor Cycling"
        case .elliptical:
            return "Elliptical"
        case .functionalStrengthTraining:
            return "Functional Strength Training"
        case .gymnastics:
            return "Gymnastics"
        case .handCycling:
            return "Hand Cycling"
        case .highIntensityIntervalTraining:
            return "HIIT"
        case .hiking:
            return "Hiking"
        case .jumpRope:
            return "Jump Rope"
        case .kickboxing:
            return "Kick Boxing"
        case .martialArts:
            return "Martial Arts"
        case .mindAndBody:
            return "Mind and Body"
        case .mixedCardio:
            return "Mixed Cardio"
        case .pilates:
            return "Pilates"
        case .preparationAndRecovery:
            return "Preparation and Recovery"
        case .rowing:
            return "Rowing"
        case .runningOutdoors:
            return "Outdoor Run"
        case .runningIndoors:
            return "Indoor Run"
        case .stairs:
            return "Stairs"
        case .stairClimbing:
            return "Stair Climbing"
        case .stepTraining:
            return "Step Training"
        case .swimming:
            return "Swimming"
        case .trackAndField:
            return "Track and Field"
        case .traditionalStrengthTraining:
            return "Traditional Strength Training"
        case .walkingIndoors:
            return "Indoor Walk"
        case .walkingOutdoors:
            return "Outdoor Walk"
        case .wheelchairRunPace:
            return "Wheelchair (Running Pace)"
        case .wheelchairWalkPace:
            return "Wheelchair (Walking Pace)"
        case .wrestling:
            return "Wrestling"
        case .yoga:
            return "Yoga"
        default:
            return "Other"
        }
    }

    var icon: String {
        switch self {
        case .boxing:
            return "figure.boxing"
        case .cooldown:
            return "figure.cooldown"
        case .crossTraining:
            return "figure.cross.training"
        case .cyclingIndoor, .cyclingOutdoor:
            return "figure.outdoor.cycle"
        case .elliptical:
            return "figure.elliptical"
        case .functionalStrengthTraining:
            return "figure.strengthtraining.functional"
        case .gymnastics:
            return "figure.gymnastics"
        case .handCycling:
            return "figure.hand.cycling"
        case .highIntensityIntervalTraining:
            return "figure.highintensity.intervaltraining"
        case .hiking:
            return "figure.hiking"
        case .jumpRope:
            return "figure.jumprope"
        case .kickboxing:
            return "figure.kickboxing"
        case .martialArts:
            return "figure.martial.arts"
        case .mindAndBody:
            return "figure.mind.and.body"
        case .mixedCardio:
            return "figure.mixed.cardio"
        case .pilates:
            return "figure.pilates"
        case .preparationAndRecovery:
            return "figure.flexibility"
        case .rowing:
            return "figure.rower"
        case .runningOutdoors, .runningIndoors:
            return "figure.run"
        case .stairs, .stairClimbing:
            return "figure.stairs"
        case .stepTraining:
            return "figure.step.training"
        case .swimming:
            return "figure.open.water.swim"
        case .trackAndField:
            return "figure.track.and.field"
        case .traditionalStrengthTraining:
            return "figure.strengthtraining.traditional"
        case .walkingIndoors, .walkingOutdoors:
            return "figure.walk"
        case .wheelchairRunPace:
            return "figure.roll"
        case .wheelchairWalkPace:
            return "figure.roll.runningpace"
        case .wrestling:
            return "figure.wrestling"
        case .yoga:
            return "figure.yoga"
        case .other:
            return "figure.cooldown"
        }
    }
}

