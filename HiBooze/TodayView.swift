//
//  TodayView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct TodayView: View {
    
    let beverageTypes: [Beverage] = [
        Beverage(title: "Beer", calories: 90, ounces: 12),
        Beverage(title: "Wine", calories: 100, ounces: 8),
        Beverage(title: "Liqour", calories: 105, ounces: 2)
    ]
    
    @State private var isShowingAddView: Bool = false
    
    var body: some View {
 
        VStack {
            Form {
                Section("Alcohol Intake") {
                    HStack(spacing: 30) {
                        Circle()
                            .frame(width: 100, height: 100)
                        VStack {
                            Text("Current")
                            Text("210 Cals")
                        }
                        VStack {
                            Text("Drinks")
                            Text("2 Drinks")
                        }
                    }
                    Text("Today's Total: 2/3 Drinks")
                }
                
                Section("Drinks of Day") {
                    HStack {
                        Text("Beer (Light)")
                        Spacer()
                        Text("105 Cals")
                    }
                    HStack {
                        Text("Beer (Light)")
                        Spacer()
                        Text("105 Cals")
                    }
                }
            }
            
            Button {
                print("Button Tapped")
                isShowingAddView = true
            } label: {
                Text("Add Drink")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .navigationTitle("Today")
        .sheet(isPresented: $isShowingAddView) {
    AddBeverageView()
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodayView()
        }
    }
}
