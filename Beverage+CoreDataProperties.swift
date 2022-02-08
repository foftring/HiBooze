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
    
    var relativeDateFormatter: RelativeDateTimeFormatter {
        RelativeDateTimeFormatter()
    }
    
    @objc var dateString: String {
        dateFormatter.string(from: timeConsumed)
    }
    
    @objc var dateStringRelative: String {
        
        var result = ""
        let today = Date()
        
        //Order matters here so you can avoid overlapping
        if Calendar.current.isDateInToday(self.timeConsumed){
            result = "Today"
        } else if Calendar.current.isDateInYesterday(self.timeConsumed) {
            result = "Yesterday"
        } else if Calendar.current.dateComponents([.day], from: self.timeConsumed, to: today).day ?? 8 <= 7 {
            result = "This Week"
        } else if Calendar.current.dateComponents([.day], from: self.timeConsumed, to: today).day ?? 31 <= 30 {
            result = "This Month"
        } else {
            result = "All Time"
        }
        
        return result
    }
    
}

extension Beverage : Identifiable {
    
    
}
