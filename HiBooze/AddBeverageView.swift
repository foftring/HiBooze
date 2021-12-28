//
//  AddBeverageView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct AddBeverageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let beverageTypes: [Beverage] = [
        Beverage(title: "Beer", calories: 90, ounces: 12),
        Beverage(title: "Wine", calories: 100, ounces: 8),
        Beverage(title: "Liqour", calories: 105, ounces: 2)
    ]
    
    var body: some View {
        List {
            ForEach(beverageTypes, id: \.self) { beverage in
                HStack {
                    VStack(alignment: .leading) {
                        Text(beverage.title)
                        Text("\(beverage.ounces.formatted())oz")
                            .font(.caption)
                    }
                    Spacer()
                    Text("\(beverage.calories) cals")
                }
            }
        }
        .navigationTitle("Add")
        .toolbar {
            ToolbarItemGroup(placement: .destructiveAction) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct AddBeverageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddBeverageView()
        }
    }
}
