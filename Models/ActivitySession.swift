//
//  ActivitySession.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 15/02/2026.
//

import Foundation

@Observable final class ActivitySession: Hashable {
    var usedIndices: [Int] = []
    var wasCorrect: Bool? = nil
    var hasBeenCompleted: Bool = false
    var completedAnswer: String? = nil
    var completedMode: String? = nil
    
    static func == (lhs: ActivitySession, rhs: ActivitySession) -> Bool {
        lhs.usedIndices == rhs.usedIndices && lhs.wasCorrect == rhs.wasCorrect && lhs.completedAnswer == rhs.completedAnswer && lhs.completedMode == rhs.completedMode
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(usedIndices)
        hasher.combine(wasCorrect)
    }
}
