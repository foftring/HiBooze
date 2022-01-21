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
    @EnvironmentObject var userSettings: UserSettings
    @State private var isShowingCreateNewBeverageTypeView: Bool = false
    
    var body: some View {
        List {
            Section {
                ForEach(userSettings.beverageTypes, id: \.self) { beverage in
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
            
            Button {
                isShowingCreateNewBeverageTypeView = true
            } label: {
                Text("Add New Beverage Type")
            }

            
        }
        .sheet(isPresented: $isShowingCreateNewBeverageTypeView) {
            NavigationView {
                CreateNewBeverageTypeView()
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
