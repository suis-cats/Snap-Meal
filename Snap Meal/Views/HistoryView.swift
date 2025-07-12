import SwiftUI

struct HistoryView: View {
    var meals: [Meal] = []

    var body: some View {
        List(meals) { meal in
            HStack {
                if let photo = meal.photo {
                    Image(uiImage: photo)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                VStack(alignment: .leading) {
                    Text(meal.time.rawValue)
                        .font(.headline)
                    if let cals = meal.calories {
                        Text("\(cals, specifier: "%.0f") kcal")
                    }
                }
            }
        }
        .navigationTitle("履歴")
    }
}
