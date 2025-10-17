//
//  ContentView.swift
//  iExpense
//
//  Created by Veselin Nikolov on 2.10.25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @State private var sortOrder = [
        SortDescriptor(\Expense.name), SortDescriptor(\Expense.category),
    ]

    @State private var newTitle: String = ""

    var body: some View {
        NavigationStack {
            ExpensesView(sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.top, 4)
                .background(Color(.systemGroupedBackground).ignoresSafeArea())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            AddView()
                        } label: {
                            Label("Add", systemImage: "plus.circle.fill")
                                .labelStyle(.iconOnly)
                                .font(.title2)
                        }
                    }

                    ToolbarItem(placement: .navigationBarLeading) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by name")
                                    .tag(
                                        [
                                            SortDescriptor(\Expense.name),
                                            SortDescriptor(\Expense.category),
                                        ]
                                    )

                                Text("Sort by category")
                                    .tag(
                                        [
                                            SortDescriptor(\Expense.category),
                                            SortDescriptor(\Expense.name),

                                        ]
                                    )
                            }
                        }
                    }
                }
        }
    }

}

#Preview {
    ContentView()
}
