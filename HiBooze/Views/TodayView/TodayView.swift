//
//  TodayView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct TodayView: View {
    
    @StateObject var viewModel = TodayViewModel()
    
    var body: some View {
        
        VStack {
            Form {
                Section("Alcohol Intake") {
                    HStack(spacing: 30) {
                        Circle()
                            .frame(width: 100, height: 100)
                        VStack {
                            Text("Current")
                            Text("\(viewModel.caloriesDrank) Cals")
                        }
                        VStack {
                            Text("Drinks")
                            Text("\(viewModel.numberOfDrinks) Drinks")
                        }
                    }
                    Text("Today's Total: \(viewModel.numberOfDrinks)/\(viewModel.goalDrinks) Drinks")
                }
                
                Section("Drinks of the Day") {
                    ForEach(viewModel.drinksOfDay, id: \.self) { beverage in
                        DrinkAndCalorieStack(title: beverage.title ?? "Blank", calories: Int(beverage.calories))
                    }
                    .onDelete { indexSet in
                        viewModel.removeAt(offsets: indexSet)
//                        viewModel.delete(beverage: beverage)
                    }
                }
            }
            
            Button {
                print("Button Tapped")
                viewModel.isShowingAddView = true
            } label: {
                Text("Add Drink")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .onAppear(perform: {
            viewModel.getBeverages()
        })
        .navigationTitle("Today")
        .sheet(isPresented: $viewModel.isShowingAddView) {
            NavigationView {
                AddBeverageView(drinksOfDay: $viewModel.drinksOfDay)
                    .environmentObject(viewModel)
            }
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

struct DrinkAndCalorieStack: View {
    
    let title: String
    let calories: Int
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(calories) Cals")
        }
    }
}
