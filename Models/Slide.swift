//
//  Slide.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 13/02/2026.
//

import Foundation

struct Slide: Identifiable, Hashable {
    enum Kind: Hashable {
        case activity(Activity)
        case info(Info)
    }
    
    let id = UUID()
    let kind: Kind
    var isComplete = false
    var activitySession = ActivitySession()
    
    static func == (lhs: Slide, rhs: Slide) -> Bool {
        lhs.id == rhs.id
    }
}
