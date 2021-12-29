//
//  HiBoozeApp.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

@main
struct HiBoozeApp: App {
    
    var userSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HBTabView()
                    .environmentObject(userSettings)
            }
        }
    }
}
