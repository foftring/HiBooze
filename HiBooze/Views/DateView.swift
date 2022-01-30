//
//  DateView.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/23/22.
//

import SwiftUI
import CoreData

struct DateView: View {
    
    @SectionedFetchRequest(
            entity: Beverage.entity(),
            sectionIdentifier: \.dateString,
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Beverage.timeConsumed, ascending: false)
            ])
        var beverages: SectionedFetchResults<String, Beverage>
    
    var body: some View {
        List {
            ForEach(beverages) { section in
                Section(header: Text(section.id)) {
                    ForEach(section) { beverage in
                        DrinkAndCalorieStack(beverage: beverage)
                    }
                }
            }
        }
        .navigationTitle("History")
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView()
    }
}
