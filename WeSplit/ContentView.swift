//
//  ContentView.swift
//  WeSplit
//
//  Created by Rafael Fagundes on 2024-08-26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    func getTotal(checkAmount: Double, tipPercentage: Int) -> Double {
        return checkAmount + (checkAmount * Double(tipPercentage)) / 100
    }
    
    func getAmountPerPerson(numberOfPeople: Int, totalAmount: Double) -> Double {
        return totalAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Bill Details")) {
                    TextField("Enter the check amount", value: $checkAmount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }

                Section(header: Text("Tip Percentage")) {
                    Picker("Select tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Total Amount & Per Person Share")) {
                    HStack {
                        Text("Total amount:")
                        Spacer()
                        Text(getTotal(checkAmount: checkAmount, tipPercentage: tipPercentage), format: .currency(code: currencyCode))
                    }
                    HStack {
                        Text("Amount per person:")
                        Spacer()
                        Text(getAmountPerPerson(numberOfPeople: numberOfPeople + 2, totalAmount: getTotal(checkAmount: checkAmount, tipPercentage: tipPercentage)), format: .currency(code: currencyCode))
                    }
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
