//
//  ExpensesView.swift
//  iExpense
//
//  Created by Veselin Nikolov on 17.10.25.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext

    @Query var expenses: [Expense]

    var body: some View {
        if expenses.isEmpty {
            VStack {
                Image(systemName: "tray")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                Text("No expenses")
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(expenses) { expense in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.name)
                                .font(.headline)

                            Text(expense.category)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Text(
                            expense.amount,
                            format: .currency(code: expense.currency)
                        )
                        .font(.subheadline).bold()
                        .padding(8)
                        .background(Color(.tertiarySystemFill))
                        .cornerRadius(8)
                        .foregroundStyle(expenseStyling(for: expense.amount))
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 10).fill(
                            Color(.secondarySystemBackground)
                        )
                    )
                    .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    delete(items: expenses, at: indexSet)
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .padding(.top, 6)
        }
    }

    init(sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(
            sort: sortOrder
        )
    }

    private func delete(items: [Expense], at offsets: IndexSet) {
        let toDelete = offsets.map { items[$0] }
        for expense in toDelete {
            modelContext.delete(expense)
        }
    }

    private func expenseStyling(for amount: Double) -> Color {
        amount <= 10 ? .red : (amount <= 100 ? .green : .blue)
    }
}

#Preview {
    ExpensesView(sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
