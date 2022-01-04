//
//  UserSettings.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/29/21.
//

import Foundation

class UserSettings: ObservableObject {
    
    @Published var drinkLimit: Int {
        didSet {
            UserDefaults.standard.set(drinkLimit, forKey: "drinkLimit")
        }
    }
    
    init() {
        self.drinkLimit = UserDefaults.standard.object(forKey: "drinkLimit") as? Int ?? 3
    }
    
}
