//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import Foundation

class TransactionUtilities {

    /// Combines and sorts an arbitrary number of lists of transactions
    /// - Parameter transactionsList: a list of lists of Transactions.
    /// - Returns: A single list of transactions, sorted by date (earliest to latest) with no duplicates
    static func combineAndSortTransactions(transactionsList: [[Transaction]]) -> [Transaction] {
        return mergeSortedLists(firstList: [], restOfLists: transactionsList)
    }

    /// Recursively sorts and merges the supplied transaction lists together
    /// - Parameters:
    ///   - firstList: A list of transactions. Assumed sorted by date (earliest to latest)
    ///   - restOfLists: A list of lists of transactions to sort and merge into firstList
    /// - Returns: Array of transactions sorted by date (earliest to latest) with no duplicates
    private static func mergeSortedLists(firstList: [Transaction], restOfLists: [[Transaction]]) -> [Transaction] {
        guard let nextList = restOfLists.first else {
            return firstList
        }

        let nextListSorted = nextList.sorted { $0.date < $1.date }
        let secondList = mergeSortedLists(firstList: nextListSorted, restOfLists: Array(restOfLists.dropFirst()))
        return combineTwoSortedLists(list1: firstList, list2: secondList)
    }

    /// Combines two transaction lists sorted by date (earliest to latest) into a single list.
    /// Runs in O(n) time, where n is the sizes of the two input lists combined
    /// - Parameters:
    ///   - list1: list of transactions sorted by date (earliest to latest)
    ///   - list2: list of transactions sorted by date (earliest to latest)
    /// - Returns: list of transactions sorted by date (earliest to latest) with no duplicantes
    static func combineTwoSortedLists(list1: [Transaction], list2: [Transaction]) -> [Transaction] {
        return list1 + list2
    }
}
