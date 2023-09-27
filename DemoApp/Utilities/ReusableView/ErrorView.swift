//
//  ErrorView.swift
//  DemoApp
//
//  Created by Nagendra on 26/09/23.
//

import SwiftUI
struct ErrorView: View {
    let errorMessage: String
    var body: some View {
        VStack {
            Text("⚠️ \(errorMessage)")
                .multilineTextAlignment(.center)
                .padding()
                .accessibilityIdentifier("errorText")
        }
        .padding()
        
    }
}
