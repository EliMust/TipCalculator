//  ContentView.swift
//  Tip calculator

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    
    let tipPercentages = [0, 10, 20, 50]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection //сколько денег составляет выбранный %
        let grandAmount = orderAmount + tipValue //финальная сумма к оплате
        let amountPerPerson = grandAmount / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<30) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Сколько % чаевых вы хотите оставить официанту?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationTitle("Калькулятор чаевых")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
