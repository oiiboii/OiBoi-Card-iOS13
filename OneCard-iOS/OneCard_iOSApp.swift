//
//  OneCard_iOSApp.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/7/23.
//

import SwiftUI
import Firebase

@main
struct OneCard_iOSApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
