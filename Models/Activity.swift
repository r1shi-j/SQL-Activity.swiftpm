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
    let tip: String?
    let hint: String?
    let schema: String?
    let answer: String
    let initialBlocks: [Block]
    
    init(
        question: String,
        tip: String? = nil,
        hint: String?,
        schema: String? = nil,
        answer: String,
        blocks: [String]
    ) {
        self.question = question
        self.tip = tip
        self.hint = hint
        self.schema = schema
        self.answer = answer
        self.initialBlocks = blocks.map { Block(content: $0) }
    }
}
