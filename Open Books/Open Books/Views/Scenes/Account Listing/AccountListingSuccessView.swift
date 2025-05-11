//
//  AccountListingSuccessView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct AccountListingSuccessView: View {
    var accounts: PaginatedData<TransparentAccount>
    var isLoadingMore: Bool
    var onLoadMore: () -> Void
    
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(accounts.items, id: \.accountNumber) { account in
                AccountRowView(account: account)
            }
            
            if isLoadingMore {
                VStack {
                    ProgressView()
                    
                    Text("Loading more accounts...")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .task {
                    onLoadMore()
                }
            }
        }
    }
}

#Preview {
    AccountListingSuccessView(
        accounts: .singlePage(TransparentAccount.mockList),
        isLoadingMore: false,
        onLoadMore: {}
    )
}
