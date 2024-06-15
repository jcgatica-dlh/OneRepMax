//
//  OneRepMaxDocument.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var workoutHistory: UTType {
        UTType(importedAs: "com.workouts-r-us.workout-history")
    }
}

struct WorkoutDocument: FileDocument {
    var workouts : [Workout]
    var history : [WorkoutHistory]

    init() {
        history = []
        workouts = []
    }
    
    static var readableContentTypes: [UTType] { [.workoutHistory] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        workouts = try Workout.decodeWorkouts(string)
        history = WorkoutHistory.collateData(workouts)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        fatalError("Writing not allowed")
    }
}
