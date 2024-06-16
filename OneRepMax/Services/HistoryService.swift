//
//  OneRepMaxDocument.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI
import UniformTypeIdentifiers

enum HistoryError: Error {
    case fileNotAccessible
}

protocol HistoryProvider {
    func importFile(fileURL: URL) async throws
    func fetchHistory() async -> [WorkoutHistory]
}

actor HistoryService: HistoryProvider {
    static let shared = HistoryService()
    private var workouts = [Workout]()
    private var history = [WorkoutHistory]()
    
    private init() {
    }

    func importFile(fileURL: URL) async throws {
        if !fileURL.startAccessingSecurityScopedResource() {
            throw HistoryError.fileNotAccessible
        }
        
        defer {
            fileURL.stopAccessingSecurityScopedResource()
        }

        let data = try Data(contentsOf: fileURL)

        guard let string = String(data: data, encoding: .utf8) else {
            throw HistoryError.fileNotAccessible
        }

        workouts = try Workout.decodeWorkouts(string)
        history = WorkoutHistory.collateData(workouts)
        
        try? await Task.sleep(for: .seconds(1))
    }
    
    func fetchHistory() -> [WorkoutHistory] {
        return history
    }
}
