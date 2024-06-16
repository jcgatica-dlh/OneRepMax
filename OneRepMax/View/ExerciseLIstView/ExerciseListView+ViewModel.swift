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
        private var historyProvider: HistoryProvider

        init(coordinator: RootCoordinator, historyProvider: HistoryProvider, exerciseList: [WorkoutHistory] = []) {
            self.coordinator = coordinator
            self.exerciseList = exerciseList
            self.historyProvider = historyProvider
        }
        
        func start() async {
            self.exerciseList = await historyProvider.fetchHistory()
        }
        
        func displayDetails(_ row: WorkoutHistory) {
            coordinator.pushPage(.workoutHistory(row))
        }
    }
}
