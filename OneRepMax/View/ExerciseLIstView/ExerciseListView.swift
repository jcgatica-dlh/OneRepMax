//
//  ContentView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI

@MainActor
struct ExerciseListView: View {
    //@EnvironmentObject private var coordinator : RootCoordinator
    @StateObject var viewModel : ExerciseListView.ViewModel
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.exerciseList, id: \.name) { row in
                WorkoutSummaryView(row: row)
                    .onTapGesture {
                        viewModel.displayDetails(row)
                    }
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    let vm = ExerciseListView.ViewModel(coordinator: RootCoordinator(),
                                        exerciseList: [WorkoutHistory(name: "A", workouts: [Workout(date: .now, name: "A", reps: 3, weight: 40.0)])])
    return ExerciseListView(viewModel: vm)
}
