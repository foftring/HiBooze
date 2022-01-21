//
//  CreateNewBeverageType.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/16/22.
//

import SwiftUI

struct CreateNewBeverageTypeView: View {
    
    @State private var beverageTitle: String = ""
    @State private var beverageCalories: Int = 0
    @State private var beverageOunces: Int = 0
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        Form {
            TextField("Title", text: $beverageTitle)
            HStack {
                Text("Calories:")
                TextField("", value: $beverageCalories, format: .number)
                    .keyboardType(.decimalPad)
            }
            HStack {
                Text("Ounces:")
                TextField("", value: $beverageOunces, format: .number)
                    .keyboardType(.decimalPad)
            }
            
            Button {
                print("Save")
                userSettings.addNewBeverageType(title: beverageTitle, calories: beverageCalories, ounces: beverageOunces)
            } label: {
                Text("Save")
            }

        }
    }
}

struct CreateNewBeverageType_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewBeverageTypeView()
    }
}
