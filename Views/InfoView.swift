//
//  InfoView.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import SwiftUI

struct InfoView: View {
    let info: Info
    let isLast: Bool
    let onCompletion: () -> Void
    
    init(info: Info, isLast: Bool, onCompletion: @escaping () -> Void) {
        self.info = info
        self.isLast = isLast
        self.onCompletion = onCompletion
    }
    
    var body: some View {
        VStack {
            Text(info.title)
                .font(.title)
                .padding()
            
            Spacer()
            
            Text("SubHeading 1")
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text(info.paragraph1)
                .padding()
            
            Divider().padding(.vertical)
            
            Text("SubHeading 2")
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text(info.paragraph2)
                .padding()
            
            Divider().padding(.vertical)
            
            Text("SubHeading 3")
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text(info.paragraph3)
                .padding()
            
            Spacer()
        }
        .background {
            Color.orange.opacity(0.2).ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(isLast ? "Finish" : "Next", role: .confirm, action: onCompletion)
                    .font(.title)
                    .padding(8)
                    .buttonStyle(.glassProminent)
                    .tint(.blue)
            }
        }
    }
}
