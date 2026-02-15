//
//  ActivitySession.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 15/02/2026.
//

import Foundation

@Observable final class ActivitySession: Hashable {
    var usedIndices: [Int] = []
    var wasCorrect: Bool? = nil
    var hasBeenCompleted: Bool = false
    
    static func == (lhs: ActivitySession, rhs: ActivitySession) -> Bool {
        lhs.usedIndices == rhs.usedIndices && lhs.wasCorrect == rhs.wasCorrect
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(usedIndices)
        hasher.combine(wasCorrect)
    }
}
