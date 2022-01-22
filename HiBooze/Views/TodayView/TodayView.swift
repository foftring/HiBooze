//
//  TodayView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct TodayView: View {
    
    @StateObject var viewModel = TodayViewModel()
    @EnvironmentObject var userSettings: UserSettings
    
    var progressValue: Float {
        Float(viewModel.numberOfDrinks) / Float(userSettings.drinkLimit)
    }
    
    var body: some View {
        VStack {
            Form {
                Section("Alcohol Intake") {
                    HStack(spacing: 30) {
                        
                        
                        ProgressBar(progress: progressValue)
                            .frame(width: 100, height: 100)
                            .padding()
                        
                        VStack(spacing: 15) {
                            Text("Current Stats")
                                .bold()
                            HStack {
                                Text("\(viewModel.caloriesDrank) Cals")
                                Text("\(viewModel.numberOfDrinks) Drinks")
                            }
                        }
                    }
                    Text("Today's Total: \(viewModel.numberOfDrinks)/\(userSettings.drinkLimit) Drinks")
                    Button {
                        withAnimation {
                            viewModel.resetDrinksOfDay()
                        }
                    } label: {
                        Text("Clear All Drinks")
                    }
                }
                
                if !viewModel.drinksOfDay.isEmpty {
                    Section("Drinks of the Day") {
                        ForEach(viewModel.drinksOfDay, id: \.self) { beverage in
                            DrinkAndCalorieStack(beverage: beverage)
                        }
                        .onDelete { indexSet in
                            viewModel.removeAt(offsets: indexSet)
                        }
                    }
                } else {
                    ZStack {
                        EmptyState()
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Text("No Drinks Added Yet!")
                                .font(.title)
                                .bold()
                            Text("Add One Below to Get Started")
                        }
                        //                            .foregroundColor(.pink)
                    }
                }
            }
            
            Button {
                viewModel.isShowingAddView = true
            } label: {
                Text("Add Drink")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .onAppear(perform: {
            viewModel.getBeverages()
            viewModel.healthStore.getAuthStatus()
        })
        .navigationTitle("Today")
        .sheet(isPresented: $viewModel.isShowingAddView) {
            NavigationView {
                AddBeverageView()
                    .environmentObject(viewModel)
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodayView()
                .environmentObject(UserSettings())
        }
    }
}

struct DrinkAndCalorieStack: View {
    
    let beverage: Beverage
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(beverage.title ?? "")
                Text("\(beverage.ounces.formatted()) oz")
                    .font(.callout)
            }
            Spacer()
            Text("\(beverage.calories) Cals")
        }
    }
}
