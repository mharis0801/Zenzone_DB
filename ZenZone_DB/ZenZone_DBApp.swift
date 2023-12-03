//
//  ZenZone_DBApp.swift
//  ZenZone_DB
//
//  Created by Muhammad Haris on 02/12/2023.
//

import SwiftUI
import Firebase
import UIKit

@main
struct ZenZone_DBApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    //    @UIApplicationDelegateAdaptor{AppDelegate.self} var appDelegate
    var body: some Scene {
        WindowGroup {
            let user = FireDBHelper()
            LaunchView().environmentObject(user)
                
        }
    }
}

//class AppDelegate: NSObject, UIApplicationDelegate{
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions:
//                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}
