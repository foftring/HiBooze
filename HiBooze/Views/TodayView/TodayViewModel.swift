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
    let viewContext: NSManagedObjectContext
    
    var healthStore = HealthStore.shared
    
    static let beverageTypes: [MockBeverage] = [
        MockBeverage(title: "Beer", calories: 90, ounces: 12),
        MockBeverage(title: "Wine", calories: 100, ounces: 8),
        MockBeverage(title: "Liqour", calories: 105, ounces: 2)
    ]
    
    @Published var isShowingAddView: Bool = false
    @Published var drinksOfDay: [Beverage] = []
    
    var numberOfDrinks: Int {
        drinksOfDay.count
    }
    
    var caloriesDrank: Int {
        drinksOfDay.reduce(0) { partialResult, beverage in
            Int(beverage.calories) + partialResult
        }
    }
    
    init() {
        viewContext = persistenceController.container.viewContext
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
    
    func add(beverage: MockBeverage) {
        
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
    
    func updateBeverages() {
        persistenceController.save()
        getBeverages()
    }
}
