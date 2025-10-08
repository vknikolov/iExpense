//
//  ContentView.swift
//  iExpense
//
//  Created by Veselin Nikolov on 2.10.25.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    //    @State private var showingAddExpense = false
    @State private var newTitle: String = ""

    var body: some View {
        NavigationStack {
            List {
                categorySection(items: expenses.personal, category: .personal)

                categorySection(items: expenses.business, category: .business)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddView(expenses: expenses)
                    } label: {
                        Text("Add Expense")                    }
                }
             
                //                Button("Add Expense", systemImage: "plus") {
                //                    showingAddExpense = true
                //                }
            }
            //            .sheet(isPresented: $showingAddExpense) {
            //                AddView(expenses: expenses)
            //       }
        }
    }

    @ViewBuilder
    func categorySection(items: [ExpenseItem], category: Category) -> some View
    {

        if items.isEmpty {
            Text("No expenses data for \(category.rawValue).")
        } else {
            Section(category.rawValue) {
                ForEach(items, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)

                            Text(item.type.rawValue)
                        }

                        Spacer()

                        Text(
                            item.amount,
                            format: .currency(code: item.currency)
                        )
                        .foregroundStyle(
                            expenseStyling(for: item.amount)
                        )
                    }
                }
                .onDelete { indexSet in
                    removeItem(at: indexSet, category: category)
                }
            }
        }

    }

    func removeItem(at offsets: IndexSet, category: Category) {
        switch category {
        case .business:
            expenses.business.remove(atOffsets: offsets)
        default:
            expenses.personal.remove(atOffsets: offsets)
        }
    }

    func expenseStyling(for amount: Double) -> Color {
        amount <= 10 ? .red : (amount <= 100 ? .green : .blue)
    }
}

#Preview {
    ContentView()
}
