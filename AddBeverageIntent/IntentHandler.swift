//
//  IntentHandler.swift
//  AddBeverageIntent
//
//  Created by Frank Oftring on 1/8/22.
//

import Intents
import CoreData

class IntentHandler: INExtension, AddBeverageIntentHandling {
    
    let persistenceController = PersistenceController.shared
    let viewContext: NSManagedObjectContext
    
    override init() {
        self.viewContext = persistenceController.container.viewContext
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        guard intent is AddBeverageIntent else {
            fatalError("Unknown intent type: \(intent)")
        }
        
        print("Running handler")
        
        return self
    }
    
    public func confirm(intent: AddBeverageIntent, completion: @escaping (AddBeverageIntentResponse) -> Void) {
        completion(AddBeverageIntentResponse(code: .ready, userActivity: nil))
        print("running confirm")
    }
    
    func handle(intent: AddBeverageIntent, completion: @escaping (AddBeverageIntentResponse) -> Void) {
        
        guard let title = intent.title,
              let calories = intent.calories,
              let ounces = intent.ounces else {
                  completion(AddBeverageIntentResponse.init(code: .failure, userActivity: nil))
                  print("Wrong intent type")
                  return
              }
        
        let intCalories = Int(truncating: calories)
        let intOunces = Int(truncating: ounces)
        
        let result = addBeverage(title: title, calories: intCalories, ounces: intOunces)
        
        print(result)
        
        if result {
            print("Completion run!")
            completion(AddBeverageIntentResponse.success(calories: calories, ounces: ounces, title: title))
        } else {
            print("Completion not run!")
            completion(AddBeverageIntentResponse.failure(title: title))
        }
        
    }
    
    func addBeverage(title: String, calories: Int, ounces: Int) -> Bool {
        
        var result: Bool = false
        
        if var beverages = persistenceController.getBeverages() {
            
            let newBeverage = Beverage(context: viewContext)
            newBeverage.title = title
            newBeverage.calories = Int16(calories)
            newBeverage.ounces = Double(ounces)
            newBeverage.timeConsumed = Date()
            
            beverages.append(newBeverage)
            
            print("appending bevererage")
            
            persistenceController.save()
            result = true
            print(result)
            return result
        } else {
            print(result)
            return result
        }
        
        
        
        
    }
    
    // MARK: - Resolution Methods
    
    func resolveTitle(for intent: AddBeverageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
        if let title = intent.title {
            completion(INStringResolutionResult.success(with: title))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
        
    }
    
    func resolveCalories(for intent: AddBeverageIntent, with completion: @escaping (AddBeverageCaloriesResolutionResult) -> Void) {
        if let calories = intent.calories {
            completion(AddBeverageCaloriesResolutionResult.success(with: Int(truncating: calories)))
        } else {
            completion(AddBeverageCaloriesResolutionResult.needsValue())
        }
    }
    
    func resolveOunces(for intent: AddBeverageIntent, with completion: @escaping (AddBeverageOuncesResolutionResult) -> Void) {
        if let ounces = intent.ounces {
            completion(AddBeverageOuncesResolutionResult.success(with: Int(truncating: ounces)))
        } else {
            completion(AddBeverageOuncesResolutionResult.needsValue())
        }
    }
    
    
}
