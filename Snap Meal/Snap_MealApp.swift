//
//  Snap_MealApp.swift
//  Snap Meal
//
//  Created by Suis on 2025/07/13.
//

import SwiftUI
import SwiftData

@main
struct Snap_MealApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CameraView()
        }
        .modelContainer(sharedModelContainer)
    }
}
