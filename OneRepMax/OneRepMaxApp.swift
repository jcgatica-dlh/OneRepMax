//
//  OneRepMaxApp.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI

@main
struct OneRepMaxApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: OneRepMaxDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
