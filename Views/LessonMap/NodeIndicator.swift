//
//  NodeIndicator.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 26/02/2026.
//

import SwiftUI

struct NodeIndicator: View {
    @Environment(AppSettings.self) private var settings
    
    let status: LessonMapView.Status
    
    var body: some View {
        if status == .completed {
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(nodeFill)
        } else {
            ZStack {
                Circle()
                    .fill(nodeFill)
                    .frame(width: 22, height: 22)
                Circle()
                    .strokeBorder(nodeFill, lineWidth: 2)
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    private var nodeFill: Color {
        switch status {
            case .completed:
                return .green
            case .current:
                return settings.accentColorOption.color
            case .locked:
                return .gray
        }
    }
}
