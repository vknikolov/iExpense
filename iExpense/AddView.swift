//
//  AddView.swift
//  iExpense
//
//  Created by Veselin Nikolov on 2.10.25.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var type: String = "Business"
    @State private var amount: Double = 0.0
    @State private var selectedCurrency = "USD"
    
    let categories = ["Business", "Personal"]
    let currency = ["USD", "EUR", "AUD", "CAD", "CHF", "GBP", "JPY", "BGN"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                    }
                }

                Picker("Select Currency", selection: $selectedCurrency) {
                    ForEach(currency, id: \.self) {
                        Text($0)
                    }
                }

                TextField(
                    "Amount",
                    value: $amount,
                    format: .currency(code: selectedCurrency)
                )
                .keyboardType(.decimalPad)

            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let expense = Expense(
                        name: name,
                        category: type,
                        amount: amount,
                        currency: selectedCurrency
                    )
                    if type == "Business" {
                        modelContext.insert(expense)
                    } else {
                        modelContext.insert(expense)
                    }

                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView()
}
