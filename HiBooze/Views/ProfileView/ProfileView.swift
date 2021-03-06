//
//  ProfileView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(.secondarySystemBackground))
                
                HStack(spacing: 25) {
                    Image(uiImage: viewModel.profileImage)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            viewModel.isShowingPhotoPicker = true
                        }
                        .padding(.leading)
                    
                    VStack {
                        TextField("First Name", text: $userSettings.firstName)
                            .profileNameStyle()
                        TextField("Last Name", text: $userSettings.lastName)
                            .profileNameStyle()
                    }
                    .padding(.trailing, 16)
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
            .cornerRadius(20)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.isShowingPhotoPicker, content: {
            PhotoPicker(profileImage: $viewModel.profileImage)
        })
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
