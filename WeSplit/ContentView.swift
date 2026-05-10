//
//  ContentView.swift
//  WeSplit
//
//  Created by Gabriele Dell’Erba on 10/05/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        Form {
            Section {
                TextField(
                    "Amount", value: $checkAmount,
                    format: .currency(
                        code: Locale.current.currency?.identifier ?? "USD"))
            }
        }
    }
}

#Preview {
    ContentView()
}
