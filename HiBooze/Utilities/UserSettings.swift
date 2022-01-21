//
//  UserSettings.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/29/21.
//

import Foundation

class UserSettings: ObservableObject {
    
    enum USKeys: String {
        case drinkLimit = "drinkLimit"
        case beverageTypes = "beverageTypes"
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
    
    func addNewBeverageType(title: String, calories: Int, ounces: Int) {
        let newBeverage = BeverageType(title: title, calories: calories, ounces: Double(ounces))
        
        beverageTypes.append(newBeverage)
        self.saveBevTypes()
    }
}
