import SwiftUI

/// Overlay with 3x3 grid and golden ratio guides for the camera preview.
struct CameraOverlayView: View {
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let thirdW = width / 3
            let thirdH = height / 3
            let goldenX = width * 0.618
            let goldenY = height * 0.618
            Path { path in
                // 3x3 grid
                for i in 1..<3 {
                    let x = thirdW * CGFloat(i)
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                    let y = thirdH * CGFloat(i)
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: width, y: y))
                }
                // Golden ratio
                path.move(to: CGPoint(x: goldenX, y: 0))
                path.addLine(to: CGPoint(x: goldenX, y: height))
                path.move(to: CGPoint(x: 0, y: goldenY))
                path.addLine(to: CGPoint(x: width, y: goldenY))
            }
            .stroke(Color.white.opacity(0.6), lineWidth: 1)
        }
    }
}

#Preview {
    CameraOverlayView()
}
