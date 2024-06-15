//
//  WorkoutSummaryView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/14/24.
//

import SwiftUI

struct WorkoutSummaryView: View {
    let row: WorkoutHistory
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading) {
                Text(row.name)
                    .font(.title)
                Text("One Rep Max • lbs")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(verbatim: "\(Int(row.oneRepMax()))")
                .font(.title)
        }
        .padding()
    }
}

#Preview {
    WorkoutSummaryView(row: WorkoutHistory(name: "A", workouts: [Workout(date: .now, name: "A", reps: 3, weight: 40.0)]))
}
