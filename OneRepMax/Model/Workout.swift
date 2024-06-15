//
//  Workout.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import Foundation

struct Workout : Hashable, CustomDebugStringConvertible {
    static var debugFormatter = { () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    var debugDescription: String {
        let dateString = Self.debugFormatter.string(for: date)!
        return "\(dateString) - \(name) - Reps: \(reps) - Weight: \(weight)"
    }
    
    let date: Date
    let name: String
    let reps: Int
    let weight: Double
    
    var oneRepMax : Double {
        weight * 36.0 / Double(37 - reps)
    }
}

extension Workout {
    enum ParseFailure : Error {
        case invalidFormat
    }
        
    fileprivate static let formatter = { () -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }()
    
    static func decodeWorkouts(_ input: String) throws -> [Workout] {
        let lines = input.split(separator: "\n")
        
        return try lines.map { line -> Workout in
            let parts = line.split(separator: ",")
            if parts.count != 4 { throw ParseFailure.invalidFormat }
            
            guard let date = formatter.date(from: String(parts[0])) else { throw ParseFailure.invalidFormat }
            let reps = try Int(String(parts[2]), format: .number)
            let weight = try Double(String(parts[3]), format: .number)
            
            return Workout(date: date, name: String(parts[1]), reps: reps, weight: weight)
        }
    }
}
