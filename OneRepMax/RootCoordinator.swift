//
//  RootCoordinator.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI

@MainActor
enum Page: Hashable {
    case exerciseView
    case workoutHistory(WorkoutHistory)
    
    @ViewBuilder
    func createView(coordinator: RootCoordinator) -> some View {
        switch self {
        case .exerciseView:
            ExerciseListView(viewModel: ExerciseListView.ViewModel(coordinator: coordinator, historyProvider: HistoryService.shared))
        case .workoutHistory(let history):
            let viewModel = WorkoutHistoryView.ViewModel(coordinator: coordinator, history: history)
            WorkoutHistoryView(viewModel: viewModel)
        }
    }
}

@MainActor
final class RootCoordinator : ObservableObject {
    @Published var path = NavigationPath()
    
    func createRootView() -> some View {
        WelcomeView(viewModel: WelcomeView.ViewModel(coordinator: self, historyProvider: HistoryService.shared))
    }
    
    func createPage(_ page: Page) -> some View {
        return page.createView(coordinator: self)
    }
    
    func pushPage(_ page: Page) {
        path.append(page)
    }
}
