import Foundation
import SwiftUI

/// Represents a meal captured by the user.
///
/// `Codable` conformance was removed because `UIImage` does not conform to
/// `Codable`. Encoding/decoding can be added later with a custom
/// implementation if persistence is required.
struct Meal: Identifiable {

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
