//
//  ContentView.swift
//  QuintKitPlayground
//
//  Created by Marco Quinten on 16.11.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink {
                    InputsView()
                } label: {
                    Text("Inputs")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
