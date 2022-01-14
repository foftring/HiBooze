//
//  ProgressBar.swift
//  HiBooze
//
//  Created by Frank Oftring on 1/14/22.
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

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 0.25)
            .padding(50)
    }
}
