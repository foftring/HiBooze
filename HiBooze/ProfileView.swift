//
//  ProfileView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        VStack(spacing: 30) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(.secondarySystemBackground))
            }
            
            RoundedRectangle(cornerRadius: 20)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
