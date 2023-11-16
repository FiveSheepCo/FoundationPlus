//
//  InputsView.swift
//  QuintKitPlayground
//
//  Created by Marco Quinten on 16.11.23.
//

import SwiftUI
import QuintKitUI

struct InputsView: View {
    @State private var dictationTextFieldText = String()
    
    var body: some View {
        Form {
            DictationTextField("DictationTextField", text: $dictationTextFieldText)
        }
    }
}

#Preview {
    InputsView()
}
