//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation
import Testing
@testable import KonradBanking

struct KonradBankingTests {

    //@Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
   // }

    private func makeTransaction(
        day: Int,
        description: String = "Coffee",
        source: BankDataSource = .KIBK
    ) -> Transaction {
        Transaction(
            date: Date(timeIntervalSince1970: TimeInterval(day * 86_400)),
            value: 10,
            description: description,
            source: source,
            tags: []
        )
    }

    @Test func emptyInputReturnsEmptyList() {
        #expect(TransactionUtilities.combineAndSortTransactions(transactionsList: []).isEmpty)
        #expect(TransactionUtilities.combineAndSortTransactions(transactionsList: [[], []]).isEmpty)
    }

    @Test func singleUnsortedListIsSortedLatestFirst() {
        let day1 = makeTransaction(day: 1)
        let day2 = makeTransaction(day: 2)
        let day3 = makeTransaction(day: 3)

        let result = TransactionUtilities.combineAndSortTransactions(transactionsList: [[day1, day3, day2]])

        #expect(result == [day3, day2, day1])
    }

    @Test func multipleListsAreMergedLatestFirst() {
        let day1 = makeTransaction(day: 1, source: .BKO)
        let day2 = makeTransaction(day: 2, source: .RBK)
        let day3 = makeTransaction(day: 3, source: .KIBK)
        let day4 = makeTransaction(day: 4, source: .KD)

        let result = TransactionUtilities.combineAndSortTransactions(transactionsList: [
            [day1, day4],
            [day3],
            [day2]
        ])

        #expect(result == [day4, day3, day2, day1])
    }

    @Test func duplicatesAreRemoved() {
        let day1 = makeTransaction(day: 1)
        let day2 = makeTransaction(day: 2)

        let result = TransactionUtilities.combineAndSortTransactions(transactionsList: [
            [day1, day2, day2],
            [day2, day1]
        ])

        #expect(result == [day2, day1])
    }

    @Test func differentTransactionsOnSameDateAreKept() {
        let coffee = makeTransaction(day: 1, description: "Coffee")
        let pizza = makeTransaction(day: 1, description: "Pizza")
        let tip = makeTransaction(day: 1, description: "Tip")

        let result = TransactionUtilities.combineAndSortTransactions(transactionsList: [[coffee], [pizza],[tip]])

        #expect(result.count == 3)
        #expect(result.contains(coffee))
        #expect(result.contains(pizza))
    }

}
