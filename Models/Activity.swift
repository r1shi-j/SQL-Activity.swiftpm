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
    let blocks: [String]
}
