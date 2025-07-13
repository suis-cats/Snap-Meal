import Foundation
import SwiftUI

struct Meal: Identifiable, Codable {
    enum MealTime: String, Codable, CaseIterable {
        case breakfast = "朝"
        case lunch = "昼"
        case dinner = "夜"
    }

    var id = UUID()
    /// Raw image data persisted for the meal. Use the `photo` computed
    /// property for easy UIImage access within the app.
    var photoData: Data?
    var time: MealTime
    var carbs: Double?
    var calories: Double?
    var protein: Double?
    var notes: String?
    /// Convenience wrapper around `photoData` so SwiftUI views can work with
    /// `UIImage` directly while still allowing the struct to conform to
    /// `Codable`.
    var photo: UIImage? {
        get {
            guard let data = photoData else { return nil }
            return UIImage(data: data)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.9)
        }
    }
}
