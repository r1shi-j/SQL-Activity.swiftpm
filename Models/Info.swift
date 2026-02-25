//
//  Info.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 13/02/2026.
//

import Foundation

struct InfoSection: Equatable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let body: String
}

struct Info: Equatable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let sections: [InfoSection]
}
