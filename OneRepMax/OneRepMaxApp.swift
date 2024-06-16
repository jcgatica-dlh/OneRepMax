//
//  OneRepMaxApp.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI

@main
struct OneRepMaxApp: App {
    @StateObject var coordinator = RootCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                coordinator.createRootView()
                    .navigationDestination(for: Page.self) { page in
                        coordinator.createPage(page)
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
