//
//  InfoView.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import SwiftUI

struct InfoView: View {
    let info: Info
    let onCompletion: () -> Void
    
    init(info: Info, onCompletion: @escaping () -> Void) {
        self.info = info
        self.onCompletion = onCompletion
    }
    
    var body: some View {
        Text("Hello, World!")
    }
}
