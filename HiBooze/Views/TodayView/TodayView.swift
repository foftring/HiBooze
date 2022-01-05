//
//  TodayView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct ProgressBar: View {
    
    let progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            Text(String(format: "%.0f %%", min(progress, 1.0)*100.0))
                .font(.title2)
        }
    }
    
}

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
                        
                        
                        VStack {
                            Text("Current")
                            Text("\(viewModel.caloriesDrank) Cals")
                        }
                        VStack {
                            Text("Drinks")
                            Text("\(viewModel.numberOfDrinks) Drinks")
                        }
                    }
                    Text("Today's Total: \(viewModel.numberOfDrinks)/\(userSettings.drinkLimit) Drinks")
                }
                
                Section("Drinks of the Day") {
                    ForEach(viewModel.drinksOfDay, id: \.self) { beverage in
                        DrinkAndCalorieStack(beverage: beverage)
                    }
                    .onDelete { indexSet in
                        viewModel.removeAt(offsets: indexSet)
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
            viewModel.healthStore?.getAuthStatus()
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
