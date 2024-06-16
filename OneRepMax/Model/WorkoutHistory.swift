//
//  WorkoutHistory.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import Foundation
import Algorithms

struct WorkoutHistory : Hashable {
    let name: String
    let workouts: [Workout]

    func oneRepMax() -> Double {
        workouts.max { a, b in
            a.oneRepMax < b.oneRepMax
        }?.oneRepMax ?? 0.0
    }
    
    /// Returns a subset of workout records, only keeping the workout with the largest OneRepMax
    /// for any group of workouts that were performed within the specified number of days
    /// Prevents the graph from looking so busy. 
    /// TODO: Consider returning the average instead of the max
    /// - Parameter days: Number of days to consider when grouping workouts
    /// - Returns: A filtered list of workouts
    func filterWorkouts(days: Int = 15) -> [Workout] {
        let chunkInterval = 60.0 * 60.0 * 24.0 * Double(days)
        let byDate = workouts.chunked { a, b in
            fabs(a.date.distance(to: b.date)) < chunkInterval
        }
        
        return byDate.compactMap { workouts -> Workout? in
            // Only return workout with largest One Rep Max in the group
            workouts.max { a, b in
                a.oneRepMax < b.oneRepMax
            }
        }
    }
}

extension WorkoutHistory : Identifiable {
    var id: String {
        name
    }
}

extension Array where Element == Workout {
    func sortedByDate() -> [Element] {
        return sorted { a, b in
            a.date < b.date
        }
    }
}

extension Array where Element == WorkoutHistory {
    func sortedByName() -> [Element] {
        return sorted { a, b in
            a.name < b.name
        }
    }
}

extension WorkoutHistory {
    /// Separates workouts by name, and builds WorkoutHistory with those groups.  Makes sure the workout array
    ///   in WorkoutHistory is sorted by date.
    /// - Parameter workouts: Array of Workout structs
    /// - Returns: Array of WorkoutHistory structs sorted by name
    static func collateData(_ workouts: [Workout]) -> [WorkoutHistory] {
        let byName = workouts.grouped(by: \.name)
        
        return byName.map { name, workouts -> WorkoutHistory in
            WorkoutHistory(name: name, workouts: workouts.sortedByDate())
        }.sortedByName()
    }
}
