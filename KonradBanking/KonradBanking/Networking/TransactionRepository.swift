//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation
import SwiftUI

enum BankDataSource {
    case KIBK, BKO, RBK, KD

    var color: Color {
        switch self {
        case .KIBK: return .red
        case .BKO: return .blue
        case .RBK: return .gray
        case .KD: return .green
        }
    }
}

struct Transaction {
    let date: Date
    let value: Double
    let description: String
    let source: BankDataSource
    let tags: [String]
}

// This is a pretty bad assumption for what it means for two transactions to be the same,
// but you can assume it is 'correct' for this test. In reality we would want the API to
// provide some kind of unique ID for every transaction.
// You do not need to change this definition in any way.
extension Transaction: Identifiable, Equatable {
    var id: String {
        String(describing: self)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.date == rhs.date
        && lhs.value == rhs.value
        && lhs.description == rhs.description
        && lhs.source == rhs.source
        && lhs.tags == rhs.tags
    }
}

@MainActor
class TransactionRepository {
    static func getAllTransactions() async -> [Transaction] {
        async let kibkTransactions = fetchKIBKTransactions()
        async let rbkTransactions = fetchRBKTransactions()
        async let bkoTransactions = fetchBKOTransactions()
        async let kdTransactions = fetchKDTransactions()

        let transactions = await [kibkTransactions, rbkTransactions, bkoTransactions, kdTransactions]
        return TransactionUtilities.combineAndSortTransactions(transactionsList: transactions)
    }

    private static func fetchKIBKTransactions() async -> [Transaction] {
        await withCheckedContinuation { continuation in
            KIBKService.getTransactions { list in
                continuation.resume(returning: list.map { Transaction($0) })
            }
        }
    }

    private static func fetchRBKTransactions() async -> [Transaction] {
        await withCheckedContinuation { continuation in
            RBKService.getTransactions { list in
                continuation.resume(returning: list.map { Transaction($0) })
            }
        }
    }

    private static func fetchBKOTransactions() async -> [Transaction] {
        await withCheckedContinuation { continuation in
            BKOService.getTransactions { list in
                continuation.resume(returning: list.map { Transaction($0) })
            }
        }
    }

    private static func fetchKDTransactions() async -> [Transaction] {
        await withCheckedContinuation { continuation in
            KDService.getTransactions { list in
                continuation.resume(returning: list.map { Transaction($0) })
            }
        }
    }
}

// Helpers for converting API data models to application data model
extension Transaction {
    init(_ rbkTransaction: RBKTransactionResponse.RBKTransaction) {
        date = rbkTransaction.date
        value = rbkTransaction.isWithdrawal ? rbkTransaction.transactionAmount : -1 * rbkTransaction.transactionAmount
        description = rbkTransaction.description
        source = .RBK
        tags = []
    }

    init(_ bkoTransaction: BKOTransactionResponse.BKOTransaction) {
        date = bkoTransaction.date
        value = bkoTransaction.amount
        description = bkoTransaction.contact.name
        source = .BKO
        tags = []
    }

    init(_ kibkTransaction: KIBKTransactionResponse.KIBKTransaction) {
        date = kibkTransaction.date
        value = kibkTransaction.amount
        description = kibkTransaction.details
        source = .KIBK
        tags = kibkTransaction.category
    }

    init(_ kdTransaction: KDTransactionResponse.KDTransaction) {
        let isWithdrawal = kdTransaction.type == .withdrawal
        date = kdTransaction.transactionTime
        value = isWithdrawal ? kdTransaction.amount.amount : -1 * kdTransaction.amount.amount
        description = isWithdrawal ? kdTransaction.to.name : kdTransaction.from.name
        source = .KD
        tags = kdTransaction.tags ?? []
    }
}
