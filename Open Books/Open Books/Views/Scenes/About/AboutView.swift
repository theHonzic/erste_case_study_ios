import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    private var version: String {
        Bundle.main.fullVersionNumber
    }
    
    private var repositoryURL: URL {
        Configuration.repositoryURL
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 16) {
                        Image(systemName: "book.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.accentColor)
                        
                        Text("Open Books")
                            .font(.title)
                            .bold()
                        
                        Text("Version \(version)")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                
                Section("About") {
                    Text("Open Books is an iOS application that allows users to browse. The app provides a user-friendly interface for viewing account details, balances, and transaction history.")
                        .foregroundColor(.secondary)
                }
                
                Section("Features") {
                    Label("Browse transparent accounts", systemImage: "list.bullet")
                    Label("View account details", systemImage: "doc.text")
                    Label("Check account balance", systemImage: "dollarsign.circle")
                    Label("View transaction history", systemImage: "clock")
                }
                
                Section("Contact") {
                    Link(destination: repositoryURL) {
                        Label("GitHub Repository", systemImage: "link")
                    }
                }
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AboutView()
} 
