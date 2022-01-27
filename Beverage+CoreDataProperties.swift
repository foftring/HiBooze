//
//  Beverage+CoreDataProperties.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/23/22.
//
//

import Foundation
import CoreData
import SwiftUI


extension Beverage {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beverage> {
        return NSFetchRequest<Beverage>(entityName: "Beverage")
    }
    
    @NSManaged public var calories: Int16
    @NSManaged public var ounces: Double
    @NSManaged public var timeConsumed: Date
    @NSManaged public var title: String?
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd"
        return formatter
    }
    
    @objc var dateString: String {
        dateFormatter.string(from: timeConsumed)
    }
    
}

extension Beverage : Identifiable {
    
    
}
