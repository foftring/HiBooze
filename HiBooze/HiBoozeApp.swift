//
//  HiBoozeApp.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI
import Intents

@main
struct HiBoozeApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var userSettings = UserSettings()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HBTabView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(userSettings)
            }
        }
        .onChange(of: scenePhase) { phase in
            persistenceController.save()
            INPreferences.requestSiriAuthorization { authStatus in
//                print(authStatus.rawValue)
            }
        }
    }
}
