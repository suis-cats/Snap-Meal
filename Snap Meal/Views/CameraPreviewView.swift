import SwiftUI
import AVFoundation

struct CameraPreviewView: UIViewRepresentable {
    @Binding var image: UIImage?
    let session = AVCaptureSession()
    let output = AVCapturePhotoOutput()
    let queue = DispatchQueue(label: "camera.queue")

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        configureSession()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)
        session.startRunning()
        NotificationCenter.default.addObserver(forName: .capturePhoto, object: nil, queue: .main) { _ in
            let settings = AVCapturePhotoSettings()
            output.capturePhoto(with: settings, delegate: context.coordinator)
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func configureSession() {
        session.beginConfiguration()
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }
        if session.canAddInput(input) { session.addInput(input) }
        if session.canAddOutput(output) { session.addOutput(output) }
        session.commitConfiguration()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        let parent: CameraPreviewView
        init(_ parent: CameraPreviewView) { self.parent = parent }

        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let data = photo.fileDataRepresentation(), let uiImage = UIImage(data: data) {
                parent.image = uiImage
                NotificationCenter.default.post(name: .photoCaptured, object: uiImage)
            }
        }
    }
}
