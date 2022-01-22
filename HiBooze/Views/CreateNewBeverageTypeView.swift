//
//  CreateNewBeverageType.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/16/22.
//

import SwiftUI

struct CreateNewBeverageTypeView: View {
    
    @State private var beverageTitle: String = ""
    @State private var beverageCalories: String = ""
    @State private var beverageOunces: String = ""
    
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Title", text: $beverageTitle)
            HStack {
                TextField("Calories", text: $beverageCalories)
                    .keyboardType(.decimalPad)
            }
            HStack {
                TextField("Ounces", text: $beverageOunces)
                    .keyboardType(.decimalPad)
            }
            
            Button {
                print("Save")
                userSettings.addNewBeverageType(title: beverageTitle, calories: beverageCalories, ounces: beverageOunces)
                presentationMode.wrappedValue.dismiss()
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
