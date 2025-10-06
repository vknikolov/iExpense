//
//  Expenses.swift
//  iExpense
//
//  Created by Veselin Nikolov on 3.10.25.
//

import SwiftUI

enum Category: String, Codable, CaseIterable {
    case personal = "Personal"
    case business = "Business"
}

// Single expense
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: Category
    let amount: Double
    let currency: String
}

@Observable
class Expenses {
    let defaults = UserDefaults.standard

    var personal: [ExpenseItem] = [] {
        didSet {
            saveItems(for: .personal)
        }
    }

    var business: [ExpenseItem] = [] {
        didSet {
            saveItems(for: .business)
        }
    }

    init() {
        loadItems(for: .personal)
        loadItems(for: .business)
    }

    private func saveItems(for category: Category) {
        let key = category.rawValue
        let items: [ExpenseItem]

        switch category {
        case .personal:
            items = personal
        case .business:
            items = business
        }

        if let encoded = try? JSONEncoder().encode(items) {
            defaults.set(encoded, forKey: key)
        }
    }

    private func loadItems(for category: Category) {
        let key = category.rawValue

        guard let savedItems = defaults.data(forKey: key) else {
            return
        }

        if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
            switch category {
            case .personal:
                personal = decodedItems
            case .business:
                business = decodedItems
            }
        }
    }
}

