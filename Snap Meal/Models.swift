import Foundation
import SwiftUI

struct Meal: Identifiable, Codable {
    enum MealTime: String, Codable, CaseIterable {
        case breakfast = "朝"
        case lunch = "昼"
        case dinner = "夜"
    }

    var id = UUID()
    var photo: UIImage?
    var time: MealTime
    var carbs: Double?
    var calories: Double?
    var protein: Double?
    var notes: String?
}
