//
//  FormattedString.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 27/02/2026.
//

import Foundation

extension String {
    func formattedBody() -> AttributedString {
        if let attributed = try? AttributedString(markdown: self) {
            return attributed
        }
        return AttributedString(self)
    }
}
