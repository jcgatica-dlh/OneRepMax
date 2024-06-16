//
//  LoadProgressView.swift
//  OneRepMax
//
//  Created by Juan Gatica on 6/16/24.
//

import SwiftUI

struct LoadProgressView: View {
    var body: some View {
        ProgressView {
            Text("Fetching")
        }
        .padding(70)
        .background(Color("ProgressBackground"))
        .cornerRadius(5.0)
    }
}

#Preview {
    LoadProgressView()
}
