//
//  Activity.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 13/02/2026.
//

import Foundation

struct Activity: Equatable, Identifiable, Hashable {
    let id = UUID()
    let question: String
    let hint: String?
    let answer: String
    let initialBlocks: [Block]
    
    init(question: String, hint: String?, answer: String, blocks: [String]) {
        self.question = question
        self.hint = hint
        self.answer = answer
        self.initialBlocks = blocks.map { Block(content: $0) }
    }
}
