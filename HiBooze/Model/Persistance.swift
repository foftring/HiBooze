//
//  Persistance.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/7/22.
//

import Foundation
import CoreData

struct PersistenceController {
    
    private let containerName = "Beverages"
    private let entityName = "Beverage"
    
    static let coreDataBeverageTypes: [Beverage] = []
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // A singleton for our entire app to use
    static let shared = PersistenceController()
    
    // An initializer to load Core Data, optionally able to use an in-memory store.
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: containerName)
        let storeURL = URL.storeURL(for: "group.com.hibooze.foftring", databaseName: containerName)
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        storeDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        storeDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        container.persistentStoreDescriptions = [storeDescription]
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
    }
    
    // MARK: - Core Data
    
    func getBeverages() -> [Beverage]? {
        let request = NSFetchRequest<Beverage>(entityName: entityName)
        
        let predicate = NSPredicate(format: "timeConsumed >= %@", Date().startOfDay as CVarArg)
        
        request.predicate = predicate
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching")
            return nil
        }
    }
    
    func getHistoricalBeverages() -> [Beverage]? {
        let request = NSFetchRequest<Beverage>(entityName: entityName)
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching")
            return nil
        }
    }
    
    func save() {
        
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
//                print("Saving to context")
            } catch {
                print("Error saving to core data")
            }
        }
    }
    
    func delete(beverage: Beverage) {
        container.viewContext.delete(beverage)
        save()
    }
    
    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        // Create 10 example programming languages.
        for _ in 0..<10 {
            let beverage = Beverage(context: controller.container.viewContext)
            beverage.title = "Beer!"
            beverage.calories = 200
            beverage.ounces = 15
            beverage.timeConsumed = Date()
        }
        
        return controller
    }()
}
