//
//  TodayViewModel.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/28/21.
//

import Foundation
import CoreData
import Intents

class TodayViewModel: ObservableObject {
    
    let persistenceController = PersistenceController.shared
    let userSettings = UserSettings.shared
    
    let viewContext: NSManagedObjectContext
    
    var healthStore = HealthStore.shared
    
    @Published var isShowingAddView: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var drinksOfDay: [Beverage] = []
    
    var numberOfDrinks: Int {
        drinksOfDay.count
    }
    
    var caloriesDrank: Int {
        drinksOfDay.reduce(0) { partialResult, beverage in
            Int(beverage.calories) + partialResult
        }
    }
    
    let alert = AlertContext.drinkLimitReached
    
    init() {
        viewContext = persistenceController.container.viewContext
    }
    
    func drinkLimitHasBeenReached() {
        if drinksOfDay.count >= userSettings.drinkLimit {
            isShowingAlert = true
        }
    }
    
    // MARK: - Siri Shortcuts
    func makeDonation(title: String, calories: Int16, ounces: Double) {
        
        let intent = AddBeverageIntent()
        
        let nsCalories = NSNumber(value: calories)
        let nsOunces = NSNumber(value: ounces)
        
        intent.suggestedInvocationPhrase = "Add \(calories) calories from a \(ounces)oz \(title)"
        
        intent.title = title
        intent.calories = nsCalories
        intent.ounces = nsOunces
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if error != nil {
                print(error ?? "Default error")
                if let error = error as NSError? {
                    print("Donation failed" + error.localizedDescription)
                }
            } else {
                print("Successfully donated")
            }
        }
        
    }
    
    // MARK: - Core Data
    
    func getBeverages() {
        if let beverages = persistenceController.getBeverages() {
            self.drinksOfDay = beverages
        }
    }
    
    func add(beverage: BeverageType) {
        
        let newBeverage = Beverage(context: viewContext)
        newBeverage.title = beverage.title
        newBeverage.calories = Int16(beverage.calories)
        newBeverage.ounces = beverage.ounces
        newBeverage.timeConsumed = Date()
        
        self.drinksOfDay.append(newBeverage)
        updateBeverages()
        healthStore.updateHealthStore(amount: Double(newBeverage.calories))
        makeDonation(title: beverage.title, calories: Int16(beverage.calories), ounces: beverage.ounces)
    }
    
    func removeAt(offsets: IndexSet) {
        for index in offsets {
            let drink = drinksOfDay[index]
            viewContext.delete(drink)
        }
        updateBeverages()
    }
    
    func resetDrinksOfDay() {
        for drink in drinksOfDay {
            viewContext.delete(drink)
        }
        updateBeverages()
    }
    
    func updateBeverages() {
        persistenceController.save()
        getBeverages()
    }
}
