//
//  HBTabView.swift
//  HiBooze
//
//  Created by Frank Oftring on 12/27/21.
//

import SwiftUI

enum Tabs: String {
    case today, profile, history
}

struct HBTabView: View {
    
    @State var selectedTab: Tabs = .today
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                TodayView()
                    .tabItem {
                        Label("Today", systemImage: "calendar.circle.fill")
                    }
                    .tag(Tabs.today)
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
                    .tag(Tabs.profile)
                
                DateView()
                    .tabItem {
                        Label("History", systemImage: "clock.fill")
                    }
                    .tag(Tabs.history)
            }
            .navigationTitle(selectedTab.rawValue.capitalized)
            .navigationViewStyle(.automatic)
        }
    }
}

struct HBTabView_Previews: PreviewProvider {
    static var previews: some View {
        HBTabView()
    }
}
