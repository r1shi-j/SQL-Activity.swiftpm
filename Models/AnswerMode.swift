//
//  AnswerMode.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 26/02/2026.
//

import Foundation

enum AnswerMode: String, CaseIterable, Identifiable {
    case blocks
    case text
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
            case .blocks:
                return "Blocks"
            case .text:
                return "Text"
        }
    }
}
