//
//  AddView.swift
//  iExpense
//
//  Created by Veselin Nikolov on 2.10.25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var type: Category = .business
    @State private var amount: Double = 0.0
    @State private var selectedCurrency = "USD"

    var expenses: Expenses

//    let types = ["Business", "Personal"]
    let currency = ["USD", "EUR", "AUD", "CAD", "CHF", "GBP", "JPY", "BGN"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(Category.allCases, id: \.self) { category in
                        Text(category.rawValue)
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
                    let expense = ExpenseItem(
                        name: name,
                        type: type,
                        amount: amount,
                        currency: selectedCurrency
                    )
                    if type == .business {
                        expenses.business.append(expense)
                    } else {
                        expenses.personal.append(expense)
                    }

                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
