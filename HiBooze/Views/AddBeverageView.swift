//
//  AddBeverageView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct AddBeverageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var todayViewModel: TodayViewModel
    
    var body: some View {
        List {
            ForEach(TodayViewModel.beverageTypes, id: \.self) { beverage in
                HStack {
                    VStack(alignment: .leading) {
                        Text(beverage.title)
                        Text("\(beverage.ounces.formatted())oz")
                            .font(.caption)
                    }
                    Spacer()
                    Text("\(beverage.calories) cals")
                }
                .onTapGesture {
                    todayViewModel.add(beverage: beverage)
                    self.presentationMode.wrappedValue.dismiss()
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

//struct AddBeverageView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            AddBeverageView(drinksOfDay: .constant([Beverage(]))
//        }
//    }
//}
