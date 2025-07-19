import SwiftUI
import AVFoundation

struct CameraView: View {
    @State private var showPreview = false
    @State private var capturedImage: UIImage?
    @State private var showSettings = false
    @State private var showHistory = false
    @EnvironmentObject private var store: MealStore

    var body: some View {
        ZStack {
            CameraPreviewView(image: $capturedImage)
                .ignoresSafeArea()
            CameraOverlayView()
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: { showHistory.toggle() }) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.title2)
                            .padding()
                    }
                    .sheet(isPresented: $showHistory) {
                        NavigationView {
                            HistoryView()
                        }
                    }
                    Spacer()
                    Button(action: { showSettings.toggle() }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                            .padding()
                    }
                    .sheet(isPresented: $showSettings) {
                        SettingsView()
                    }
                }
                Spacer()
                Button(action: {
                    // Capture
                    NotificationCenter.default.post(name: .capturePhoto, object: nil)
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 72, height: 72)
                        .shadow(radius: 4)
                }
                .padding(.bottom, 40)
            }
            VStack {
                Image("AppLogo")
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.top, 8)
                Spacer()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .photoCaptured)) { notification in
            if let image = notification.object as? UIImage {
                capturedImage = image
                showPreview = true
            }
        }
        .fullScreenCover(isPresented: $showPreview) {
            if let img = capturedImage {
                PreviewView(image: img)
                    .environmentObject(store)
            }
        }
    }
}

extension Notification.Name {
    static let capturePhoto = Notification.Name("capturePhoto")
    static let photoCaptured = Notification.Name("photoCaptured")
    static let resumeCamera = Notification.Name("resumeCamera")
}
