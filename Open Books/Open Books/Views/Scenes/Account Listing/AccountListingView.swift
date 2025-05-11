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
                // Feature highlight box
                FeatureHighlightBox(
                    title: "Transparent Accounts",
                    icon: "sparkless",
                    features: [
                        .init(
                            icon: "doc.text.fill",
                            title: "View Account Details",
                            description: "Tap on any account to see detailed information and transaction history"
                        ),
                        .init(
                            icon: "qrcode",
                            title: "Generate Payment Code",
                            description: "Generate QR code for bank transfer to support the account"
                        )
                    ],
                    tint: .accentColor
                )
                .padding(.horizontal)
                
                // Account list
                Group {
                    switch viewModel.accounts {
                    case .empty:
                        InfoBoxView(
                            title: "No accounts",
                            description: "There are no transparent accounts available at the moment.",
                            image: "info.circle.fill",
                            tint: .yellow
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
        .onAppear {
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
