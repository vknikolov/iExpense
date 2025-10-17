//
//  Expense.swift
//  iExpense
//
//  Created by Veselin Nikolov on 17.10.25.
//

import Foundation
import SwiftData

@Model
final class Expense: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var category: String
    var amount: Double
    var currency: String

    init(name: String, category: String, amount: Double, currency: String) {
        self.name = name
        self.category = category
        self.amount = amount
        self.currency = currency
    }
}
