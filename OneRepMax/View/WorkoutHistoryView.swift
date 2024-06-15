//
//  WorkoutHistoryView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/14/24.
//

import SwiftUI
import Charts

// Charts prefer working with units that are identifiable..
extension Workout : Identifiable
{
    var id: Date {
        date
    }
}

struct WorkoutHistoryView : View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) private var dismiss
    var history: WorkoutHistory
    
    var body: some View {
        VStack {
            WorkoutSummaryView(row: history)
            Chart {
                ForEach(history.workouts, id: \.date) { element in
                    LineMark(x: .value("Date", element.date, unit: .month),
                             y: .value("lbs", element.oneRepMax))
                }
                .symbol(Circle())
                .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 5)) {
                    AxisValueLabel()
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 5)) { value in
                    AxisValueLabel() {
                        if let date = value.as(Date.self) {
                            VStack {
                                Text(date, format: .dateTime.month())
                                Text(date, format: .dateTime.year())
                            }
                        }
                    }
                }
            }
            .frame(maxHeight: 280.0)
            .padding(40)
            Spacer()
        }
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    WorkoutHistoryView(history: WorkoutHistory(name: "A", workouts: [Workout(date: .now, name: "A", reps: 3, weight: 40.0)]))
}
