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
            .alert(alertTitle, isPresented: $viewModel.showErrorAlert, actions: {
                Button("OK") {
                    viewModel.errorAcknowledged()
                }
            })
            .fileImporter(
                isPresented: $viewModel.showImporter,
                allowedContentTypes: [.plainText]
            ) { result in
                Task {
                    await viewModel.processImportResponse(result)
                }
            }
            
            if viewModel.fetching {
                ProgressView {
                    Text("Fetching")
                }
                .padding(70)
                .background(Color("ProgressBackground"))
                .cornerRadius(5.0)
            }
        }
        .navigationTitle("Welcome")
    }
}

#Preview {
    WelcomeView(viewModel: WelcomeView.ViewModel(coordinator: RootCoordinator()))
}
