//
//  Info.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 13/02/2026.
//

import Foundation

struct Info: Equatable, Identifiable, Hashable {
    let id = UUID()
    let content: String
}
