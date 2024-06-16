//
//  ExerciseListViewModel.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/15/24.
//

import SwiftUI

extension ExerciseListView {
    @MainActor
    final class ViewModel : ObservableObject {
        @Published private(set) var exerciseList: [WorkoutHistory]
        private var coordinator: RootCoordinator

        init(coordinator: RootCoordinator, exerciseList: [WorkoutHistory] = []) {
            self.coordinator = coordinator
            self.exerciseList = exerciseList
        }
        
        func start() async {
            self.exerciseList = await HistoryService.shared.fetchHistory()
        }
        
        func displayDetails(_ row: WorkoutHistory) {
            coordinator.pushPage(.workoutHistory(row))
        }
    }
}
