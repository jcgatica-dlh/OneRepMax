//
//  WorkoutHistoryView+ViewModel.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/15/24.
//

import SwiftUI
import Charts

extension WorkoutHistoryView {
    enum LabelResolution {
        case month, day
    }
    
    @MainActor
    final class ViewModel : ObservableObject {
        var coordinator: RootCoordinator
        @Published private(set) var history: WorkoutHistory
        @Published private(set) var filteredWorkouts: [Workout]
        @Published private(set) var labelResolution = LabelResolution.day

        init(coordinator: RootCoordinator, history: WorkoutHistory) {
            self.coordinator = coordinator
            self.history = history
            filteredWorkouts = history.filterWorkouts(days: 1)
            
            // If the data set spans more than say 3 months, the X axis labeling is better
            // showing months instead of days
            if let start = filteredWorkouts.first?.date, let end = filteredWorkouts.last?.date {
                let diff = fabs(start.distance(to: end))
                labelResolution = diff > 60 * 60 * 12 * 30 * 3 ? .month : .day
            }
        }
    }
}
