//
//  EmptyState.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/22/22.
//

import SwiftUI

struct EmptyState: View {
    var body: some View {
        Image("empty-state")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .opacity(0.2)
//            .blur(radius: 2)
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState()
    }
}
