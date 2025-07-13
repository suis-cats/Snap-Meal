import SwiftUI

struct CompletionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showHistory = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
            Text("登録が完了しました")
                .font(.title)
            HStack {
                Button("履歴を見る") { showHistory = true }
                    .padding()
                Button("もう一度撮る") {
                    dismiss()
                }
                .padding()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                dismiss()
            }
        }
        .sheet(isPresented: $showHistory) {
            NavigationView {
                HistoryView()
            }
        }
    }
}
