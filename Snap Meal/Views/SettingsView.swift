import SwiftUI

struct SettingsView: View {
    @State private var healthKitEnabled = true

    var body: some View {
        NavigationView {
            Form {
                Toggle("HealthKit連携", isOn: $healthKitEnabled)
                NavigationLink("プライバシーポリシー") {
                    Text("プライバシーポリシー")
                }
                HStack {
                    Text("バージョン")
                    Spacer()
                    Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                }
            }
            .navigationTitle("設定")
        }
    }
}
