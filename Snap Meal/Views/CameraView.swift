import SwiftUI
import AVFoundation

struct CameraView: View {
    @State private var showPreview = false
    @State private var capturedImage: UIImage?
    @State private var showSettings = false

    var body: some View {
        ZStack {
            CameraPreviewView(image: $capturedImage)
                .ignoresSafeArea()
            VStack {
                HStack {
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
            }
        }
    }
}

extension Notification.Name {
    static let capturePhoto = Notification.Name("capturePhoto")
    static let photoCaptured = Notification.Name("photoCaptured")
}
