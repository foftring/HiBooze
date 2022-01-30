//
//  View+Ext.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/30/22.
//

import SwiftUI

extension View {
 
    func profileNameStyle() -> some View {
        self.modifier(ProfileNameStyle())
    }
    
}
