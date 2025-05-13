import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                FeatureHighlightBoxView()
                
                Spacer()
                
                VStack(spacing: 8) {
                    Link(destination: Configuration.repositoryURL) {
                        Label {
                            Text("GitHub Repository")
                                .font(.headline)
                        } icon: {
                            Image(systemName: "chevron.right.circle")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                    Text("Version \(Bundle.main.fullVersionNumber)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(16)
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
