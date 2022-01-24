//
//  Alert.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/23/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismiss: Alert.Button
}

struct AlertContext {
    
    static let drinkLimitReached = AlertItem(title: Text("Drink Limit Reached"), message: Text("To view or adjust this number please visit settings."), dismiss: .default(Text("I'm done")))
    
}
