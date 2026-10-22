//
//  Copyright © 2024 Konrad Group. All rights reserved.
//

import SwiftUI

struct TransactionListView: View {
    @State var viewModel = TransactionListViewModel()

    var body: some View {
        List(viewModel.filteredTransactions) { transaction in
            TransactionRowView(viewModel: TransactionRowViewModel(transaction: transaction))
        }
        .listStyle(.plain)
        .safeAreaInset(edge: .top) {
            SearchBar(text: $viewModel.searchText)
        }
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color(.systemBackground)
                        .ignoresSafeArea()
                    ProgressView()
                        .controlSize(.large)
                }
            }
        }
        .navigationTitle("KG Bank Aggregator")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getAllTransactions()
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Search transactions", text: $text)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.bar)
    }
}

#Preview {
    TransactionListView()
}
