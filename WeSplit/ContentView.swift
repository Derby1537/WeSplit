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
    @FocusState private var amountIsFocused: Bool

    @State private var showCopiedMessage: Bool = false

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amoutPerPerson = grandTotal / peopleCount

        return amoutPerPerson
    }

    let tipPercentages = [0, 10, 15, 20, 25]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD")
                    )
                    #if os(iOS)
                        .keyboardType(.decimalPad)
                    #endif
                    .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    // .pickerStyle(.navigationLink) // I don't like it
                }

                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Total per person") {
                    Text(
                        totalPerPerson,
                        format: .currency(
                            code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .onTapGesture {
                        UIPasteboard.general.string = totalPerPerson.formatted(
                            .currency(
                                code: Locale.current.currency?.identifier
                                    ?? "USD"))
                        withAnimation {
                            showCopiedMessage = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showCopiedMessage = false
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
        }
        .overlay(alignment: .bottom) {
            if showCopiedMessage {
                Text("Amount copied to clipboard")
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .glassEffect()
                .clipShape(.capsule)
                .padding(.bottom, 20)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

#Preview {
    ContentView()
}
