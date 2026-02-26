//
//  ButtonStyles.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import SwiftUI

struct GlassBlockButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, *) {
            configuration.label
                .font(.title)
                .padding()
                .frame(minWidth: 100)
                .glassEffect(.regular.interactive().tint(color))
                .tint(.primary)
        } else {
            configuration.label
                .font(.title)
                .padding()
                .background(color)
                .clipShape(.capsule)
                .padding()
                .frame(minWidth: 100)
                .tint(.primary)
        }
    }
}
