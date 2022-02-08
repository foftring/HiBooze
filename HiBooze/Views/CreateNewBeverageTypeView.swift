//
//  CreateNewBeverageType.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/16/22.
//

import SwiftUI
import Intents

struct CreateNewBeverageTypeView: View {
    
    @State private var beverageTitle: String = ""
    @State private var beverageCalories: String = ""
    @State private var beverageOunces: String = ""
    
    var isValidForm: Bool {
        let intCalories = Int(beverageCalories) ?? 0
        let doubleOunces = Double(beverageOunces) ?? 0.0
        
        if intCalories > 0, intCalories <= 1000, doubleOunces > 0, doubleOunces < 100.0 {
            return true
        } else { return false}
    }
    
    var imageName: String { isValidForm ? "checkmark.circle.fill" : "x.circle.fill" }
    var imageColor: Color { isValidForm ? .green : .red }
    
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            HStack {
                TextField("Title", text: $beverageTitle)
            }
            HStack {
                TextField("Calories", text: $beverageCalories)
                    .keyboardType(.numberPad)
            }
            HStack {
                TextField("Ounces", text: $beverageOunces)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                HStack {
                    Button {
                        print("Save")
                        userSettings.addNewBeverageType(title: beverageTitle, calories: beverageCalories, ounces: beverageOunces)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(!isValidForm)
                    
                    Spacer()
                    
                    Image(systemName: imageName)
                        .foregroundColor(imageColor)
                }
                if !isValidForm {
                    Text("Calories must be bwteen 0 and 1000.\nOunces must be between 0 and 100")
                        .font(.caption)
                    .foregroundColor(.red)
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    XDismissButton()
                }

            }
        }
    }
}


struct CreateNewBeverageType_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewBeverageTypeView()
    }
}
