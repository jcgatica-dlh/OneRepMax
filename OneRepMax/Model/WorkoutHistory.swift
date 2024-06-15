//
//  WorkoutHistory.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import Foundation

struct WorkoutHistory : Hashable {
    let name: String
    let workouts: [Workout]

    func oneRepMax() -> Double {
        workouts.max { a, b in
            a.oneRepMax < b.oneRepMax
        }?.oneRepMax ?? 0.0
    }
}

extension WorkoutHistory : Identifiable {
    var id: String {
        name
    }
}

extension WorkoutHistory {
    /// Separates workouts by name, and builds WorkoutHistory with those groups.  Makes sure the workout array
    ///   in WorkoutHistory is sorted by date.
    /// - Parameter workouts: Array of Workout structs
    /// - Returns: Array of WorkoutHistory structs sorted by name
    static func collateData(_ workouts: [Workout]) -> [WorkoutHistory] {
        var buckets = [String:[Workout]]()
        for w in workouts {
            buckets[w.name, default: []].append(w)
        }
        
        return buckets.keys.sorted().map {
            let workouts = buckets[$0]!/*.sorted { a, b in
                a.date < b.date
            }*/
            return WorkoutHistory(name: $0, workouts: workouts)
        }
    }
}
