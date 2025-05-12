//
//  TransactionDetailsView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct TransactionDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: TransactionDetailsViewModel
    
    init(transaction: Transaction) {
        self._viewModel = .init(wrappedValue: .init(transaction: transaction))
    }
    var body: some View {
        NavigationView {
            Color.red
                .navigationTitle("Transaction Details")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                }
        }
    }
}
