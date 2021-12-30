//
//  HealthStore.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/30/21.
//

import Foundation
import HealthKit

class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func getAuthStatus() {
        
        guard let healthStore = healthStore else {
            return
        }
        
        let authStatus = healthStore.authorizationStatus(for: HKQuantityType(.numberOfAlcoholicBeverages))
        
        switch authStatus {
        case .notDetermined:
            requestAuthorization { success in
                print(success)
            }
        case .sharingDenied:
            print("Error: Sharing Denied")
        case .sharingAuthorized:
            print("Authorized!")
        }
        
        
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        
        let caloriesConsumed = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        let numberOfAlcoholicDrinks = HKObjectType.quantityType(forIdentifier: .numberOfAlcoholicBeverages)!
        
        guard let healthStore = healthStore else {
            completion(false)
            return
        }
        
        healthStore.requestAuthorization(toShare: [caloriesConsumed, numberOfAlcoholicDrinks], read: [caloriesConsumed, numberOfAlcoholicDrinks]) { success, error in
            completion(success)
        }
        
    }
    
    func addAlcoholicDrink() {
        
        let drinkToAdd = HKQuantityType(.numberOfAlcoholicBeverages)
        let beverageCount = HKQuantity(unit: HKUnit.count(), doubleValue: 1.0)
        
        let date = Date()
        
        let beverageSample = HKQuantitySample(type: drinkToAdd, quantity: beverageCount, start: date, end: date)
        
        saveToHealthStore(sample: beverageSample)
    }
    
    func addCalories(amount: Double) {
        
        let caloriesConsumed = HKQuantityType(.dietaryEnergyConsumed)
        let calorieCount = HKQuantity(unit: .largeCalorie(), doubleValue: amount)
        
        let date = Date()
        
        let calorieSample = HKQuantitySample(type: caloriesConsumed, quantity: calorieCount, start: date, end: date)
        
        saveToHealthStore(sample: calorieSample)
    }
    
    func saveToHealthStore(sample: HKQuantitySample) {
        if let healthStore = healthStore {
            healthStore.save(sample) { success, error in
                if success {
                    print("Successfully save")
                } else {
                    if let error = error {
                        print("_____ERROR SAVING TO HEALTH")
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func deleteDrink() {
        
        let drinkToDelete = HKQuantityType(.numberOfAlcoholicBeverages)
        let beverageCount = HKQuantity(unit: HKUnit.count(), doubleValue: 1.0)
        
        let date = Date()
        
        let beverageSample = HKQuantitySample(type: drinkToDelete, quantity: beverageCount, start: date, end: date)
        
        if let healthStore = healthStore {
            healthStore.delete(beverageSample) { success, error in
                if success {
                    print("successfully deleted object")
                } else {
                    print("ERROR _____")
                    print(error!)
                }
            }
        }
        
    }
    
}
