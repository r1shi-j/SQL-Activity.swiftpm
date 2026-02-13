//
//  Info.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 13/02/2026.
//

import Foundation

struct Info: Equatable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let paragraph1: String
    let paragraph2: String
    let paragraph3: String
}
