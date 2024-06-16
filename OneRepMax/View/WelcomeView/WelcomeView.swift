//
//  WelcomeView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/14/24.
//

import SwiftUI

@MainActor
struct WelcomeView: View {
    @ObservedObject var viewModel: ViewModel

    let alertTitle = "Unable to open file"
    
    var body: some View {
        ZStack {
            Button {
                viewModel.showBrowser()
            } label: {
                Label("Choose workout file", systemImage: "doc.circle")
            }
            .font(.title)
            .alert(alertTitle, isPresented: $viewModel.showErrorAlert, actions: {
                Button("OK") {
                    viewModel.errorAcknowledged()
                }
            })
            .fileImporter(
                isPresented: $viewModel.showImporter,
                allowedContentTypes: [.plainText],
                onCompletion: scheduleImport(_:)
            )
            
            if viewModel.fetching {
                LoadProgressView()
                    .transition(.opacity)
            }
        }
        .onOpenURL(perform: { url in
            scheduleImport(.success(url))
        })
        .navigationTitle("Welcome")
    }
    
    func scheduleImport(_ result: Result<URL,any Error>) {
        Task {
            await viewModel.processImportResponse(result)
        }
    }
}

#Preview {
    struct TestProvider : HistoryProvider {
        func importFile(fileURL: URL) async throws {
        }
        
        func fetchHistory() async -> [WorkoutHistory] {
            return [WorkoutHistory(name: "A", workouts: [Workout(date: .now, name: "A", reps: 3, weight: 40.0)])]
        }
    }
    return WelcomeView(viewModel: WelcomeView.ViewModel(coordinator: RootCoordinator(), historyProvider: TestProvider()))
}
