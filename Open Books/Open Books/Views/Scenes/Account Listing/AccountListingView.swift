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
    @State private var isAboutSheetPresented = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                FeatureHighlightBoxView()
                .padding(.horizontal)
                
                // Account list
                Group {
                    switch viewModel.accounts {
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
                        InfoBoxView(
                            title: "Something went wrong",
                            description: error.localizedDescription,
                            image: "exclamationmark.triangle.fill",
                            tint: .red
                        )
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .onFirstAppear {
            viewModel.onAppear()
        }
        .navigationTitle("Browse Accounts")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAboutSheetPresented = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $isAboutSheetPresented) {
            AboutView()
        }
    }
}

#Preview {
    NavigationStack {
        AccountListingView()
    }
}
