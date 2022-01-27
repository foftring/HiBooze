//
//  HBTabView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

struct HBTabView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "calendar.circle.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            DateView()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
        }
    }
}

struct HBTabView_Previews: PreviewProvider {
    static var previews: some View {
        HBTabView()
    }
}
