//
//  CustomModifiers.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/30/22.
//

import SwiftUI

struct ProfileNameStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.75)
    }
}
