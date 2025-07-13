import Foundation
import SwiftUI

@MainActor
class MealStore: ObservableObject {
    @Published private(set) var meals: [Meal] = []
    private let fileURL: URL

    init() {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = documents.appendingPathComponent("meals.json")
        load()
    }

    func add(meal: Meal) {
        meals.append(meal)
        save()
    }

    func delete(at offsets: IndexSet) {
        meals.remove(atOffsets: offsets)
        save()
    }

    private func load() {
        guard let data = try? Data(contentsOf: fileURL) else { return }
        if let decoded = try? JSONDecoder().decode([Meal].self, from: data) {
            self.meals = decoded
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(meals) else { return }
        try? data.write(to: fileURL)
    }
}
