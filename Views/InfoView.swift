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
        ScrollView {
            VStack(spacing: 16) {
                Text(info.title)
                    .font(.title)
                    .padding(.top)
                
                ForEach(Array(info.sections.enumerated()), id: \.element.id) { index, section in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(section.title)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(section.body)
                    }
                    .padding(.horizontal)
                    
                    if index != info.sections.indices.last {
                        Divider()
                    }
                }
                
                Spacer(minLength: 24)
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                if #available(iOS 26.0, *) {
                    Button(isLast ? "Finish" : "Next", action: onCompletion)
                        .font(.title)
                        .padding(8)
                        .buttonStyle(.glassProminent)
                        .tint(.blue)
                } else {
                    Button(isLast ? "Finish" : "Next", action: onCompletion)
                        .font(.title)
                        .padding(8)
                        .background(.blue)
                        .clipShape(.capsule)
                        .padding()
                        .tint(.primary)
                }
            }
        }
    }
}
