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
        DocumentGroup(viewing: WorkoutDocument.self) { file in
            coordinator.createRootView(file.document.history)
                .sheet(item: $coordinator.fullScreenCover) { item in
                    coordinator.displayFullScreen(item)
                }

        }
    }
}
