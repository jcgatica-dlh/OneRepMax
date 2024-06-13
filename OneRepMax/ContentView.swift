//
//  ContentView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/13/24.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: OneRepMaxDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(OneRepMaxDocument()))
}
