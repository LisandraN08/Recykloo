//
//  RecyklooApp.swift
//  Recykloo
//
//  Created by Lisandra Nicoline on 15/07/24.
//

import SwiftUI
import SwiftData

@main
struct RecyklooApp: App {
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
            WasteCategoryView()
        }
        .modelContainer(sharedModelContainer)
    }
}
