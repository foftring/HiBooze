//
//  UserSettings.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/29/21.
//

import Foundation

class UserSettings: ObservableObject {
    
    static let shared = UserSettings()
    
    enum USKeys: String {
        case drinkLimit = "drinkLimit"
        case beverageTypes = "beverageTypes"
        case firstName = "firstName"
        case lastName = "lastName"
    }
    
    @Published var firstName: String {
        didSet {
            UserDefaults.standard.set(firstName, forKey: USKeys.firstName.rawValue)
        }
    }
    @Published var lastName: String {
        didSet {
            UserDefaults.standard.set(lastName, forKey: USKeys.lastName.rawValue)
        }
    }
    
    @Published var drinkLimit: Int {
        didSet {
            UserDefaults.standard.set(drinkLimit, forKey: USKeys.drinkLimit.rawValue)
        }
    }
    
    @Published var beverageTypes: [BeverageType] = [
        BeverageType(title: "Beer", calories: 90, ounces: 12),
        BeverageType(title: "Wine", calories: 100, ounces: 8),
        BeverageType(title: "Liqour", calories: 105, ounces: 2)
    ]
    
    
    init() {
        self.drinkLimit = UserDefaults.standard.object(forKey: USKeys.drinkLimit.rawValue) as? Int ?? 3
        self.firstName = UserDefaults.standard.object(forKey: USKeys.firstName.rawValue) as? String ?? ""
        self.lastName = UserDefaults.standard.object(forKey: USKeys.lastName.rawValue) as? String ?? ""
        self.getBevTypes()
    }
    
    // Beverage Types
    
    func saveBevTypes() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(beverageTypes)
            
            UserDefaults.standard.set(data, forKey: USKeys.beverageTypes.rawValue)
        } catch {
            print("Unable to Encode (\(error))")
        }
    }
    
    func getBevTypes() {
        if let data = UserDefaults.standard.data(forKey: USKeys.beverageTypes.rawValue) {
            do {
                let decoder = JSONDecoder()
                self.beverageTypes = try decoder.decode([BeverageType].self, from: data)
            } catch {
                print("Error")
            }
        }
    }
    
    func deleteBeverageType(offsets: IndexSet) {
        
        self.beverageTypes.remove(atOffsets: offsets)
        saveBevTypes()
    }
    
    func addNewBeverageType(title: String, calories: String, ounces: String) {
        
        let intCalories = Int(calories) ?? 0
        let doubleOunces = Double(ounces) ?? 0.0
        
        let roundedOunces = round(doubleOunces * 100) / 100.0

        
        let newBeverage = BeverageType(title: title, calories: intCalories, ounces: roundedOunces)
        
        beverageTypes.append(newBeverage)
        self.saveBevTypes()
    }
}
