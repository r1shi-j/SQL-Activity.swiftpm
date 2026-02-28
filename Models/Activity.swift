//
//  Activity.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 13/02/2026.
//

import Foundation

struct Activity: Equatable, Identifiable, Hashable {
    let id = UUID()
    let question: String
    let tip: String?
    let hint: String?
    let schemas: [String]
    let acceptedAnswers: [String]
    let initialBlocks: [Block]
    
    init(
        question: String,
        tip: String? = nil,
        hint: String? = nil,
        schemas: [String] = [],
        acceptedAnswers: [String],
        blocks: [String]
    ) {
        precondition(!acceptedAnswers.isEmpty, "Activity.acceptedAnswers must contain at least one SQL answer.")
        
        self.question = question
        self.tip = tip
        self.hint = hint
        self.schemas = schemas
        self.acceptedAnswers = acceptedAnswers
        self.initialBlocks = blocks.shuffled().map { Block(content: $0) }
    }
}
