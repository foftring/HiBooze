//
//  TodayViewModel.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/28/21.
//

import Foundation
import CoreData

class TodayViewModel: ObservableObject {
    
    private let container: NSPersistentContainer
    private let containerName = "Beverages"
    private let entityName = "Beverage"
    
    static let beverageTypes: [MockBeverage] = [
        MockBeverage(title: "Beer", calories: 90, ounces: 12),
        MockBeverage(title: "Wine", calories: 100, ounces: 8),
        MockBeverage(title: "Liqour", calories: 105, ounces: 2)
    ]
    
    @Published var isShowingAddView: Bool = false
    @Published var drinksOfDay: [Beverage] = []
    
    var healthStore: HealthStore?
    
    var numberOfDrinks: Int {
        drinksOfDay.count
    }
    
    var caloriesDrank: Int {
        drinksOfDay.reduce(0) { partialResult, beverage in
            Int(beverage.calories) + partialResult
        }
    }
    
    init() {
        healthStore = HealthStore()
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.getBeverages()
            }
        }
    }
    
    // MARK: - Core Data
    
    func getBeverages() {
        let request = NSFetchRequest<Beverage>(entityName: entityName)
        
        do {
            self.drinksOfDay = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching")
        }
    }
    
    func add(beverage: MockBeverage) {
        let newBeverage = Beverage(context: container.viewContext)
        newBeverage.title = beverage.title
        newBeverage.calories = Int16(beverage.calories)
        newBeverage.ounces = beverage.ounces
        newBeverage.timeConsumed = Date()
        
        self.drinksOfDay.append(newBeverage)
        updateCoins()
        updateHealthStore()
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to core data")
        }
    }
    
    func removeAt(offsets: IndexSet) {
        updateHealthStore()
        for index in offsets {
            let drink = drinksOfDay[index]
            container.viewContext.delete(drink)
        }
        updateCoins()
    }
    
    func delete(beverage: Beverage) {
        updateHealthStore()
        container.viewContext.delete(beverage)
        updateCoins()
    }
    
    func updateCoins() {
        save()
        getBeverages()
    }
    
    // MARK: - HealthKit
    
    func updateHealthStore(amount: Double = 1) {
        if let healthStore = healthStore {
            healthStore.addAlcoholicDrink()
            healthStore.addCalories(amount: amount)
        }
    }
}
