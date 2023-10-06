//
//  HKWorkoutActvityTypeExtension.swift
//  Worktout Pals Watch App
//
//  Created by Neftalí Lara on 10/6/23.
//

import Foundation
import HealthKit

enum ActivityGroup {
    case basics, recovery, sports, other
}

//Maybe Extending this Types is a bad idea, check the documentation
extension HKWorkoutActivityType: Identifiable, CaseIterable, Encodable, Decodable {
    public var id: Self { self }

    public static var basicActivities: [HKWorkoutActivityType]{
        return [.running, .crossTraining, .functionalStrengthTraining, .swimming, .traditionalStrengthTraining, .highIntensityIntervalTraining, .cycling, .hiking, .walking]
    }

    public static var cardioActivities: [HKWorkoutActivityType] {
        return [.elliptical, .handCycling, .mixedCardio, .stairs, .stairClimbing, .stepTraining]
    }

    public static var sportActivities: [HKWorkoutActivityType] {
        return [.boxing, .gymnastics, .jumpRope, .kickboxing, .martialArts, .rowing, .trackAndField, .wrestling]
    }

    public static var warmupAndCooldownActivities: [HKWorkoutActivityType] {
        return [.cooldown, .mindAndBody, .preparationAndRecovery]
    }

    public static var mixedActivities: [HKWorkoutActivityType]{
        return [.pilates, .yoga, .wheelchairRunPace, .wheelchairWalkPace, .other]
    }

    public static var allCases: [HKWorkoutActivityType] {
        return [.boxing,
            .cooldown,
            .crossTraining,
            .cycling,
            .elliptical,
            .functionalStrengthTraining,
            .gymnastics,
            .handCycling,
            .highIntensityIntervalTraining,
            .hiking,
            .jumpRope,
            .kickboxing,
            .martialArts,
            .mindAndBody,
            .mixedCardio,
            .pilates,
            .preparationAndRecovery,
            .rowing,
            .running,
            .stairs,
            .stairClimbing,
            .stepTraining,
            .swimming,
            .trackAndField,
            .traditionalStrengthTraining,
            .walking,
            .wheelchairRunPace,
            .wheelchairWalkPace,
            .wrestling,
            .yoga,
            .other]

//        return [.running,
//            .americanFootball,
//            .archery,
//            .australianFootball,
//            .badminton,
//            .baseball,
//            .basketball,
//            .bowling,
//            .boxing,
//            .climbing,
//            .cricket,
//            .crossTraining,
//            .curling,
//            .cycling,
//            .socialDance,
//            .elliptical,
//            .equestrianSports,
//            .fencing,
//            .fishing,
//            .functionalStrengthTraining,
//            .golf,
//            .gymnastics,
//            .handball,
//            .hiking,
//            .hockey,
//            .hunting,
//            .lacrosse,
//            .martialArts,
//            .mindAndBody,
//            .paddleSports,
//            .play,
//            .preparationAndRecovery,
//            .racquetball,
//            .rowing,
//            .rugby,
//            .sailing,
//            .skatingSports,
//            .snowSports,
//            .soccer,
//            .softball,
//            .squash,
//            .stairClimbing,
//            .surfingSports,
//            .swimming,
//            .tableTennis,
//            .tennis,
//            .trackAndField,
//            .traditionalStrengthTraining,
//            .volleyball,
//            .walking,
//            .waterFitness,
//            .waterPolo,
//            .waterSports,
//            .wrestling,
//            .yoga,
//            .barre,
//            .coreTraining,
//            .crossCountrySkiing,
//            .downhillSkiing,
//            .flexibility,
//            .highIntensityIntervalTraining,
//            .jumpRope,
//            .kickboxing,
//            .pilates,
//            .snowboarding,
//            .stairs,
//            .stepTraining,
//            .wheelchairWalkPace,
//            .wheelchairRunPace,
//            .taiChi,
//            .mixedCardio,
//            .handCycling,
//            .discSports,
//            .fitnessGaming,
//            .cardioDance,
//            .socialDance,
//            .pickleball,
//            .cooldown,
//            .swimBikeRun,
//            .other]


    }

    var name: String {
        switch self {
        case .running:
            return "Running"
        case .americanFootball:
            return "American Football"
        case .archery:
            return "Archery"
        case .australianFootball:
            return "Australian Football"
        case .badminton:
            return "Badminton"
        case .baseball:
            return "Baseball"
        case .basketball:
            return "Basketball"
        case .bowling:
            return "Bowling"
        case .boxing:
            return "Boxing"
        case .climbing:
            return "Climbing"
        case .cricket:
            return "Cricket"
        case .crossTraining:
            return "Cross Training"
        case .curling:
            return "Curling"
        case .cycling:
            return "Cycling"
        case .dance:
            return "Dance"
        case .danceInspiredTraining:
            return "Dance Inspired Training"
        case .elliptical:
            return "Elliptical"
        case .equestrianSports:
            return "Equestrian Sports"
        case .fencing:
            return "Fencing"
        case .fishing:
            return "Fishing"
        case .functionalStrengthTraining:
            return "Functional Strength Training"
        case .golf:
            return "Golf"
        case .gymnastics:
            return "Gymnastics"
        case .handball:
            return "Handball"
        case .hiking:
            return "Hiking"
        case .hockey:
            return "Hockey"
        case .hunting:
            return "Hunting"
        case .lacrosse:
            return "Lacrosse"
        case .martialArts:
            return "Martial Arts"
        case .mindAndBody:
            return "Mind And Body"
        case .mixedMetabolicCardioTraining:
            return "Mixed Metabolic Cardio Training"
        case .paddleSports:
            return "Paddle Sports"
        case .play:
            return "Play"
        case .preparationAndRecovery:
            return "Preparation And Recovery"
        case .racquetball:
            return "Racquetball"
        case .rowing:
            return "Rowing"
        case .rugby:
            return "Rugby"
        case .sailing:
            return "Sailing"
        case .skatingSports:
            return "Skating Sports"
        case .snowSports:
            return "Snow Sports"
        case .soccer:
            return "Soccer"
        case .softball:
            return "Softball"
        case .squash:
            return "Squash"
        case .stairClimbing:
            return "Stair Climbing"
        case .surfingSports:
            return "Surfing Sports"
        case .swimming:
            return "Swimming"
        case .tableTennis:
            return "Table Tennis"
        case .tennis:
            return "Tennis"
        case .trackAndField:
            return "Track And Field"
        case .traditionalStrengthTraining:
            return "Traditional Strength Training"
        case .volleyball:
            return "Volleyball"
        case .walking:
            return "Walking"
        case .waterFitness:
            return "Water Fitness"
        case .waterPolo:
            return "Water Polo"
        case .waterSports:
            return "Water Sports"
        case .wrestling:
            return "Wrestling"
        case .yoga:
            return "Yoga"
        case .barre:
            return "Barre"
        case .coreTraining:
            return "Core Training"
        case .crossCountrySkiing:
            return "Cross Country Skiing"
        case .downhillSkiing:
            return "Downhill Skiing"
        case .flexibility:
            return "Flexibility"
        case .highIntensityIntervalTraining:
            return "High Intensity Interval Training"
        case .jumpRope:
            return "Jump Rope"
        case .kickboxing:
            return "Kickboxing"
        case .pilates:
            return "Pilates"
        case .snowboarding:
            return "Snowboarding"
        case .stairs:
            return "Stairs"
        case .stepTraining:
            return "Step Training"
        case .wheelchairWalkPace:
            return "Wheelchair (Walking Pace)"
        case .wheelchairRunPace:
            return "Wheelchair (Running Pace)"
        case .taiChi:
            return "Tai Chi"
        case .mixedCardio:
            return "Mixed Cardio"
        case .handCycling:
            return "Hand Cycling"
        case .discSports:
            return "Disc Sports"
        case .fitnessGaming:
            return "Fitness Gaming"
        case .cardioDance:
            return "Cardio Dance"
        case .socialDance:
            return "Social Dance"
        case .pickleball:
            return "Pickleball"
        case .cooldown:
            return "Cooldown"
        case .swimBikeRun:
            return "Swim Bike Run"
        case .transition:
            return "Transition"
        case .other:
            return "Other"
        case .underwaterDiving:
            return "Underwater Diving"
        @unknown default:
            return "Unknown"
        }
    }

    var icon: String {
        switch self {
        case .running:
            return "figure.run"
        case .americanFootball:
            return "figure.american.football"
        case .archery:
            return "figure.archery"
        case .australianFootball:
            return "figure.australian.football"
        case .badminton:
            return "figure.badminton"
        case .baseball:
            return "figure.baseball"
        case .basketball:
            return "figure.basketball"
        case .bowling:
            return "figure.bowling"
        case .boxing:
            return "figure.boxing"
        case .climbing:
            return "figure.climbing"
        case .cricket:
            return "figure.cricket"
        case .crossTraining:
            return "figure.cross.training"
        case .curling:
            return "figure.curling"
        case .cycling:
            return "figure.outdoor.cycle"
        case .dance:
            return "figure.dance"
        case .danceInspiredTraining:
            return "figure.dance"
        case .elliptical:
            return "figure.elliptical"
        case .equestrianSports:
            return "figure.equestrian.sports"
        case .fencing:
            return "figure.fencing"
        case .fishing:
            return "figure.fishing"
        case .functionalStrengthTraining:
            return "figure.strengthtraining.functional"
        case .golf:
            return "figure.golf"
        case .gymnastics:
            return "figure.gymnastics"
        case .handball:
            return "figure.handball"
        case .hiking:
            return "figure.hiking"
        case .hockey:
            return "figure.hockey"
        case .hunting:
            return "figure.hunting"
        case .lacrosse:
            return "figure.lacrosse"
        case .martialArts:
            return "figure.martial.arts"
        case .mindAndBody:
            return "figure.mind.and.body"
        case .mixedMetabolicCardioTraining:
            return "figure.mixed.cardio"
        case .paddleSports:
            return "figure.sailing"
        case .play:
            return "figure.play"
        case .preparationAndRecovery:
            return "figure.cooldown"
        case .racquetball:
            return "figure.racquetball"
        case .rowing:
            return "figure.rower"
        case .rugby:
            return "figure.rugby"
        case .sailing:
            return "figure.sailing"
        case .skatingSports:
            return "figure.skating"
        case .snowSports:
            return "figure.snowboarding"
        case .soccer:
            return "figure.soccer"
        case .softball:
            return "figure.softball"
        case .squash:
            return "figure.squash"
        case .stairClimbing:
            return "figure.stair.stepper"
        case .surfingSports:
            return "figure.surfing"
        case .swimming:
            return "figure.open.water.swim"
        case .tableTennis:
            return "figure.table.tennis"
        case .tennis:
            return "figure.tennis"
        case .trackAndField:
            return "figure.track.and.field"
        case .traditionalStrengthTraining:
            return "figure.strengthtraining.traditional"
        case .volleyball:
            return "figure.volleyball"
        case .walking:
            return "figure.walk"
        case .waterFitness:
            return "figure.water.fitness"
        case .waterPolo:
            return "figure.waterpolo"
        case .waterSports:
            return "figure.pool.swim"
        case .wrestling:
            return "figure.wrestling"
        case .yoga:
            return "figure.yoga"
        case .barre:
            return "figure.barre"
        case .coreTraining:
            return "figure.core.training"
        case .crossCountrySkiing:
            return "figure.skiing.crosscountry"
        case .downhillSkiing:
            return "figure.skiing.downhill"
        case .flexibility:
            return "figure.flexibility"
        case .highIntensityIntervalTraining:
            return "figure.highintensity.intervaltraining"
        case .jumpRope:
            return "figure.jumprope"
        case .kickboxing:
            return "figure.kickboxing"
        case .pilates:
            return "figure.pilates"
        case .snowboarding:
            return "figure.snowboarding"
        case .stairs:
            return "figure.stairs"
        case .stepTraining:
            return "figure.step.training"
        case .wheelchairWalkPace:
            return "figure.roll"
        case .wheelchairRunPace:
            return "figure.roll.runningpace"
        case .taiChi:
            return "figure.taichi"
        case .mixedCardio:
            return "figure.mixed.cardio"
        case .handCycling:
            return "figure.hand.cycling"
        case .discSports:
            return "figure.disc.sports"
        case .fitnessGaming:
            return "gamecontroller.fill"
        case .cardioDance:
            return "figure.dance"
        case .socialDance:
            return "figure.socialdance"
        case .pickleball:
            return "figure.pickleball"
        case .cooldown:
            return "figure.cooldown"
        case .swimBikeRun:
            return "figure.run"
        case .transition:
            return "figure.flexibility"
        case .other:
            return "figure.highintensity.intervaltraining"
        case .underwaterDiving:
            return "water.waves.and.arrow.down"
        @unknown default:
            return "figure.strengthtraining.functional"
        }
    }

    var supportsDistance: Bool {
        switch self {
        case .running, .walking, .elliptical, .cycling, .hiking, .trackAndField, .swimming:
            return true
        default:
            return false
        }
    }

    var locationType: HKWorkoutSessionLocationType {
        switch self {
        // Indoor activities
        case .americanFootball, .archery, .australianFootball, .badminton, .baseball, .basketball, .bowling, .boxing, .climbing, .cricket, .crossTraining, .curling, .dance, .danceInspiredTraining, .elliptical, .equestrianSports, .fencing, .fishing, .functionalStrengthTraining, .golf, .gymnastics, .handball, .hockey, .hunting, .lacrosse, .martialArts, .mindAndBody, .mixedMetabolicCardioTraining, .paddleSports, .play, .preparationAndRecovery, .racquetball, .stairClimbing, .surfingSports, .tableTennis, .traditionalStrengthTraining, .waterFitness, .waterPolo, .wrestling, .yoga, .barre, .coreTraining, .flexibility, .highIntensityIntervalTraining, .jumpRope, .kickboxing, .pilates, .stairs, .stepTraining, .wheelchairWalkPace, .wheelchairRunPace, .mixedCardio, .handCycling, .discSports, .fitnessGaming, .squash, .cardioDance, .socialDance, .pickleball, .cooldown, .transition, .underwaterDiving, .waterSports, .taiChi, .other:
            return .indoor

        // Outdoor activities
        case .running, .cycling, .hiking, .rowing, .rugby, .walking, .swimming, .trackAndField, .volleyball, .crossCountrySkiing, .downhillSkiing, .snowboarding, .swimBikeRun, .sailing, .skatingSports, .snowSports, .soccer, .softball, .tennis:
            return .outdoor

        @unknown default:
            return .unknown
        }
    }
}

