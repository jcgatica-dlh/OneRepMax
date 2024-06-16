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
                            Text(date, format: dateFormat(value, resolution: viewModel.labelResolution))
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
    
    func dateFormat(_ value: AxisValue, resolution: LabelResolution) -> Date.FormatStyle {
        return switch (resolution, value.index) {
        case (.month, 0), (.month, value.count - 1): .dateTime.month().year()
        case (.month, _):                            .dateTime.month()
        case (.day, 0), (.day, value.count - 1):     .dateTime.month().day()
        case (.day, _):                              .dateTime.day()
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
