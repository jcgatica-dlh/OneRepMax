//
//  WorkoutHistoryView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/14/24.
//

import SwiftUI
import Charts

@MainActor
struct WorkoutHistoryView : View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            WorkoutSummaryView(row: viewModel.history)
            Chart {
                ForEach(viewModel.filteredWorkouts, id: \.date) { element in
                    LineMark(x: .value("Date", element.date, unit: .month),
                             y: .value("lbs", element.oneRepMax))
                }
                .symbol(Circle())
                .foregroundStyle(Color("ChartLabelColorBright"))
            }
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 5)) {
                    AxisValueLabel()
                }
            }
            .chartXAxis {
                AxisMarks(preset: .aligned,values: .automatic(desiredCount: 5)) { value in
                    AxisValueLabel {
                        if let date = value.as(Date.self) {
                            Text(date, format: dateFormat(value))
                                .foregroundStyle(labelColor(value))
                        }
                    }
                }
            }
            .frame(maxHeight: 280.0)
            .padding(40)
            Spacer()
        }
    }
    
    func dateFormat(_ value: AxisValue) -> Date.FormatStyle {
        return switch value.index {
        case 0, value.count - 1: .dateTime.month().year()
        default: .dateTime.month()
        }
    }
       
    func labelColor(_ value: AxisValue) -> Color {
        return switch value.index {
        case value.count - 1: .primary
        default: .secondary
        }
    }
}

#Preview {
    let viewModel = WorkoutHistoryView.ViewModel(coordinator: RootCoordinator(), history: WorkoutHistory(name: "A", workouts: [Workout(date: .now, name: "A", reps: 3, weight: 40.0)]))
    return WorkoutHistoryView(viewModel: viewModel)
}
