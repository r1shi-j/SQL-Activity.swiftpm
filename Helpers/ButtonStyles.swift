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
        configuration.label
            .font(.title)
            .padding()
            .foregroundStyle(.black)
            .frame(minWidth: 100)
            .glassEffect(.regular.interactive().tint(color))
    }
}
