//
//  String-Extension.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 27/02/2026.
//

import Foundation

extension String {
    func normalizedQuotes() -> String {
        self
            .replacingOccurrences(of: "‘", with: "'")
            .replacingOccurrences(of: "’", with: "'")
            .replacingOccurrences(of: "“", with: "\"")
            .replacingOccurrences(of: "”", with: "\"")
    }
    
    func formattedBody() -> AttributedString {
        let normalized = self.replacingOccurrences(of: "\r\n", with: "\n")
        
        if let attributed = try? AttributedString(markdown: normalized) {
            let originalHasLineBreaks = normalized.contains("\n")
            let renderedHasLineBreaks = String(attributed.characters).contains("\n")
            
            if originalHasLineBreaks, !renderedHasLineBreaks {
                let markdownWithHardBreaks = normalized.replacingOccurrences(of: "\n", with: "  \n")
                if let hardBreakAttributed = try? AttributedString(markdown: markdownWithHardBreaks) {
                    return hardBreakAttributed
                }
            }
            
            return attributed
        }
        
        let markdownWithHardBreaks = normalized.replacingOccurrences(of: "\n", with: "  \n")
        if let fallbackAttributed = try? AttributedString(markdown: markdownWithHardBreaks) {
            return fallbackAttributed
        }
        
        return AttributedString(normalized)
    }
    
    func formattedHelpBody() -> AttributedString {
        let decoded = decodedModelEscapes()
        
        if let markdown = try? AttributedString(markdown: decoded) {
            let sourceLineBreakCount = decoded.filter { $0 == "\n" }.count
            let renderedLineBreakCount = String(markdown.characters).filter { $0 == "\n" }.count
            
            if sourceLineBreakCount == 0 || renderedLineBreakCount > 0 {
                return markdown
            }
        }
        
        return AttributedString(decoded)
    }
    
    private func decodedModelEscapes() -> String {
        var decoded = self.replacingOccurrences(of: "\r\n", with: "\n")
        
        for _ in 0..<3 {
            decoded = decoded
                .replacingOccurrences(of: "\\n", with: "\n")
                .replacingOccurrences(of: "\\r", with: "\r")
                .replacingOccurrences(of: "\\t", with: "\t")
        }
        
        return decoded
    }
}
