//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation

@MainActor
@Observable
class TransactionListViewModel {
    var transactions = [Transaction]()

    func getAllTransactions() {
        TransactionRepository.getAllTransactions { [weak self] response in
            self?.transactions = response
        }
    }
}
