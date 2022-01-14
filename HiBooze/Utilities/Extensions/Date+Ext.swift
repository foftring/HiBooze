//
//  Date+Ext.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/30/21.
//

import Foundation

extension Date {
    
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
}
