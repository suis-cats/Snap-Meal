import SwiftUI

// Temporary mock service to provide food analysis results

struct PreviewView: View {
    let image: UIImage
    @State private var selectedTime: Meal.MealTime = .breakfast
    @State private var predictions: [FoodPrediction] = []
    @State private var showCompletion = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: MealStore

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
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

                ForEach(predictions) { item in
                    VStack(alignment: .leading) {
                        Text(item.name).font(.headline)
                        HStack {
                            Text("炭水化物 \(Int(item.carbs))g")
                            Spacer()
                            Text("カロリー \(Int(item.calories))kcal")
                            Spacer()
                            Text("タンパク質 \(Int(item.protein))g")
                        }
                        .font(.caption)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }

                Spacer(minLength: 20)

                HStack {
                    Button("撮り直し") { dismiss() }
                        .padding()
                    Spacer()
                    Button("保存") {
                        var meal = Meal(time: selectedTime)
                        meal.photo = image
                        meal.carbs = predictions.map { $0.carbs }.reduce(0, +)
                        meal.calories = predictions.map { $0.calories }.reduce(0, +)
                        meal.protein = predictions.map { $0.protein }.reduce(0, +)
                        store.add(meal: meal)
                        showCompletion = true
                    }
                        .padding()
                }
            }
            .padding()
        }
        .task {
            predictions = await FoodAnalyzer.analyze(image: image)
        }
        .onDisappear {
            NotificationCenter.default.post(name: .resumeCamera, object: nil)
        }
        .fullScreenCover(isPresented: $showCompletion) {
            CompletionView()
        }
    }
}
