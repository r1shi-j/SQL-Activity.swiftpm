//
//  Block.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 12/02/2026.
//

import Foundation

struct Block: Equatable, Hashable, Identifiable {
    let id = UUID()
    let content: String
    var isUsed = false
}
