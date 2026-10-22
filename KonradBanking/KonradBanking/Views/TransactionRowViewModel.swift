//
//  TransactionRowViewModel.swift
//  KonradBanking
//
//  Created by Rahul Gangwar on 23/10/26.
//

import SwiftUI

struct TransactionRowViewModel {
    private let transaction: Transaction

    init(transaction: Transaction) {
        self.transaction = transaction
    }

    var dateText: String {
        transaction.date.dateString.uppercased()
    }

    var descriptionText: String {
        transaction.description
    }

    var tagsText: String? {
        transaction.tags.isEmpty ? nil : transaction.tags.joined(separator: "   ")
    }

    var isDeposit: Bool {
        transaction.value < 0
    }

    var amountText: String {
        abs(transaction.value).formatted(.currency(code: "USD").locale(Locale(identifier: "en_CA")))
    }

    var amountColor: Color {
        isDeposit ? .green : .primary
    }

    var sourceText: String {
        String(describing: transaction.source)
    }

    var sourceColor: Color {
        transaction.source.color
    }
}
