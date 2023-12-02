//
//  ZenZone_DBApp.swift
//  ZenZone_DB
//
//  Created by Muhammad Haris on 02/12/2023.
//

import SwiftUI

@main
struct ZenZone_DBApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
