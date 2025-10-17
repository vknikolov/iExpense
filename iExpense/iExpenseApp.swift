//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Veselin Nikolov on 2.10.25.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
