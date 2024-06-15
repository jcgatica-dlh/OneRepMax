//
//  ContentView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI

struct ExerciseListView: View {
    @State var history: [WorkoutHistory]
    
    let displayDetails: (WorkoutHistory) -> Void
    var body: some View {
        ScrollView {
            ForEach(history, id: \.name) { row in
                WorkoutSummaryView(row: row)
                    .onTapGesture {
                        displayDetails(row)
                    }
            }
        }.listStyle(.plain)
    }
}

#Preview {
    let history = [WorkoutHistory(name: "A", workouts: [Workout(date: .now, name: "A", reps: 3, weight: 40.0)])]
    return ExerciseListView(history: history) { arg in
    }
}
