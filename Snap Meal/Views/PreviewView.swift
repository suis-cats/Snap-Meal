import SwiftUI

struct PreviewView: View {
    let image: UIImage
    @State private var selectedTime: Meal.MealTime = .breakfast
    @State private var showCompletion = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: UIScreen.main.bounds.height / 2)
            Picker("食事の時間帯", selection: $selectedTime) {
                ForEach(Meal.MealTime.allCases, id: \.self) { time in
                    Text(time.rawValue).tag(time)
                }
            }
            .pickerStyle(.segmented)
            Spacer()
            HStack {
                Button("撮り直し") {
                    dismiss()
                }
                .padding()
                Spacer()
                Button("保存") {
                    showCompletion = true
                }
                .padding()
            }
        }
        .padding()
        .fullScreenCover(isPresented: $showCompletion) {
            CompletionView()
        }
    }
}
