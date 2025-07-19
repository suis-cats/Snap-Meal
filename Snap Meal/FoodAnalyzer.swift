import Foundation
import SwiftUI

struct FoodPrediction: Identifiable, Codable {
    let id = UUID()
    var name: String
    var carbs: Double
    var calories: Double
    var protein: Double
}

struct FoodAnalyzer {
    static func analyze(image: UIImage) async -> [FoodPrediction] {
        // TODO: integrate real AI service
        return [
            FoodPrediction(name: "ご飯", carbs: 40, calories: 200, protein: 3),
            FoodPrediction(name: "味噌汁", carbs: 10, calories: 50, protein: 2)
        ]
    }
}
