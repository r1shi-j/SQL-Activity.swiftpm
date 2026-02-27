//
//  Lesson.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import Foundation

struct Lesson: Equatable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String?
    var slides: [Slide]
    var isComplete = false
}
