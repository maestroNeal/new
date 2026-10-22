//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import SwiftUI

struct TransactionListView: View {
    @State var viewModel = TransactionListViewModel()

    var body: some View {
        List(viewModel.transactions) { transaction in
            VStack(alignment: .leading) {
                Text("\(transaction.description) (\(transaction.source))")
                Text("\(transaction.date.dateString) $\(transaction.value)")
                    .font(.caption)
            }
        }
        .listStyle(.plain)
        .navigationTitle("KG Bank Aggregator")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getAllTransactions()
        }
    }
}

#Preview {
    TransactionListView()
}
