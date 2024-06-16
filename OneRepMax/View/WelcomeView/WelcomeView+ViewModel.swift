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
        @Published var fetching = false
        
        var coordinator : RootCoordinator
        
        init(coordinator: RootCoordinator) {
            self.coordinator = coordinator
        }

        func showBrowser() {
            showImporter = true
        }
        
        func processImportResponse(_ result: Result<URL, any Error>) async {
            switch result {
            case .success(let file):
                do {
                    fetching = true
                    try await HistoryService.shared.importFile(fileURL: file)
                    fetching = false
                } catch {
                    showErrorAlert = true
                }
                coordinator.pushPage(.exerciseView)
            case .failure:
                showErrorAlert = true
            }
        }
        
        func errorAcknowledged() {
            showErrorAlert = false
        }
    }
}
