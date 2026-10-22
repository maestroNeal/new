//
//  TransactionRowView.swift
//  KonradBanking
//
//  Created by Rahul Gangwar on 23/10/26.
//

import SwiftUI

struct TransactionRowView: View {
    let viewModel: TransactionRowViewModel

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.dateText)
                    .font(.subheadline)
                Text(viewModel.descriptionText)
                    .font(.title3)
                    .lineLimit(2)
                    .truncationMode(.tail)
                if let tagsText = viewModel.tagsText {
                    Text(tagsText)
                        .font(.footnote)
                        .italic()
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: 8)

            Text(viewModel.amountText)
                .font(.title3.bold())
                .foregroundStyle(viewModel.amountColor)
                .lineLimit(1)
                .layoutPriority(1)

            Text(viewModel.sourceText)
                .font(.title3)
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(4)
                .frame(width: 56, height: 56)
                .background(viewModel.sourceColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    List {
        TransactionRowView(viewModel: TransactionRowViewModel(transaction: Transaction(
            date: .now,
            value: -5000.98,
            description: "City of Konronto Tax",
            source: .KD,
            tags: ["Tax"]
        )))
        TransactionRowView(viewModel: TransactionRowViewModel(transaction: Transaction(
            date: .now,
            value: 38.40,
            description: "Ben's Shirt Emporium, where the perfect fit is always in stock",
            source: .KIBK,
            tags: ["Shops", "Clothing and Accessories"]
        )))
        TransactionRowView(viewModel: TransactionRowViewModel(transaction: Transaction(
            date: .now,
            value: 5.09,
            description: "Quantum Coffee",
            source: .BKO,
            tags: []
        )))
    }
    .listStyle(.plain)
}
