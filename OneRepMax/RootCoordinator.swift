//
//  RootCoordinator.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI

class RootCoordinator : ObservableObject {
    @Published var fullScreenCover : WorkoutHistory?
    
    func createRootView(_ history: [WorkoutHistory]) -> some  View {
        print("Coordinator: \(Unmanaged.passUnretained(self).toOpaque()) creating root view")

        return ExerciseListView(history: history) {
            self.fullScreenCover = $0
        }
    }
    
    func displayFullScreen(_ history: WorkoutHistory) -> some View {
        print("Coordinator: \(Unmanaged.passUnretained(self).toOpaque()) displaying full screen")
        print(history.workouts.map { "\($0)" }.joined(separator: "\n"))
        return NavigationStack {
            WorkoutHistoryView(history: history)
                .navigationTitle(history.name)
        }
    }
}
