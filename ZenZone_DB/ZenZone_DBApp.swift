//
//  ZenZone_DBApp.swift
//  ZenZone_DB
//
//  Created by Muhammad Haris on 02/12/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct ZenZone_DBApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LaunchView()
                
        }
    }
}
