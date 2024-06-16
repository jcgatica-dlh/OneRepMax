//
//  WorkoutHistoryView+ViewModel.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/15/24.
//

import SwiftUI
import Charts

extension WorkoutHistoryView {
    @MainActor
    final class ViewModel : ObservableObject {
        var coordinator: RootCoordinator
        @Published var history: WorkoutHistory
        @Published var filteredWorkouts: [Workout]

        init(coordinator: RootCoordinator, history: WorkoutHistory) {
            self.coordinator = coordinator
            self.history = history
            filteredWorkouts = history.filterWorkouts(days: 1)
        }
    }
}
