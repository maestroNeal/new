//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation

@MainActor
@Observable
class TransactionListViewModel {
    var transactions = [Transaction]()
    var searchText = ""
    var isLoading = false

    var filteredTransactions: [Transaction] {
        guard searchText.count >= 3 else {
            return transactions
        }
        return transactions.filter { $0.description.localizedCaseInsensitiveContains(searchText) }
    }

    func getAllTransactions() async {
        isLoading = true
        transactions = await TransactionRepository.getAllTransactions()
        isLoading = false
    }
}
