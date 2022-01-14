//
//  NSManagedObjectContext.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/14/22.
//

import Foundation
import CoreData

public extension URL {
    
    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }
        
        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
