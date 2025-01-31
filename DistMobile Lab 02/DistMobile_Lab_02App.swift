//
//  DistMobile_Lab_02App.swift
//  DistMobile Lab 02
//
//  Created by Jared Johnston on 2025-01-31.
//

import SwiftUI

@main
struct DistMobile_Lab_02App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
