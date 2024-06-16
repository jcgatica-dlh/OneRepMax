//
//  WelcomeView+ViewModel.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/15/24.
//

import SwiftUI

extension WelcomeView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Published var showImporter = false
        @Published var showErrorAlert = false
        @Published private(set) var fetching = false
        
        private var coordinator: RootCoordinator
        private var historyProvider: HistoryProvider
        
        init(coordinator: RootCoordinator, historyProvider: HistoryProvider) {
            self.coordinator = coordinator
            self.historyProvider = historyProvider
        }

        func showBrowser() {
            showImporter = true
        }
        
        func processImportResponse(_ result: Result<URL, any Error>) async {
            switch result {
            case .success(let file):
                do {
                    fetching = true
                    try await historyProvider.importFile(fileURL: file)
                    coordinator.pushPage(.exerciseView)
                } catch {
                    showErrorAlert = true
                }
                fetching = false
            case .failure:
                showErrorAlert = true
            }
        }
        
        func errorAcknowledged() {
            showErrorAlert = false
        }
    }
}
