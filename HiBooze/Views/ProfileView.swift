//
//  ProfileView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var goalDrinks: Int = 3
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(.secondarySystemBackground))
                
                HStack(spacing: 50) {
                    Circle()
                        .frame(width: 100, height: 100)
                    
                    
                    
                    Text("Frank Oftring")
                        .font(.system(size: 50))
                }
                
            }
            
            Form {
                Section("Daily Drink Limit") {
                    Text("Maximum daily intake of alcohol")
                    Picker("Drink Limit", selection: $userSettings.drinkLimit) {
                        ForEach(0..<20) { int in
                            Text("\(int)")
                        }
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle("Profile")
        .padding()
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .environmentObject(UserSettings())
        }
    }
}
