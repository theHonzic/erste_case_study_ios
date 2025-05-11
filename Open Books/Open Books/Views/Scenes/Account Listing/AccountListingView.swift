//
//  AccountListingView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Factory
import SwiftUI

struct AccountListingView: View {
    @ObservedObject var viewModel: AccountListingViewModel = Container.shared.accountListingViewModel()
    
    var body: some View {
        ScrollView {
            Group {
                switch viewModel.accounts {
                case .empty:
                    InfoCardView(
                        title: "No accounts",
                        description: "There are no transparent accounts available at the moment.",
                        image: "info.circle.fill",
                    )
                case .loading:
                    AccountListingSuccessView(
                        accounts: .singlePage(TransparentAccount.mockList),
                        isLoadingMore: false,
                        onLoadMore: {}
                    )
                        .redacted(reason: .placeholder)
                        .disabled(true)
                case .success(let data, let isLoading):
                    AccountListingSuccessView(
                        accounts: data,
                        isLoadingMore: isLoading,
                        onLoadMore: { viewModel.onLoadMore() }
                    )
                case .error(let error):
                    InfoCardView(
                        title: "Error",
                        description: error.localizedDescription,
                        image: "exclamationmark.triangle.fill",
                    )
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .navigationTitle("Browse Accounts")
    }
}

#Preview {
    AccountListingView()
}
