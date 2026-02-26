import SwiftUI

enum AccentColorOption: String, CaseIterable, Identifiable {
    case indigo
    case pink
    case teal
    case orange
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
            case .indigo:
                return "Indigo"
            case .pink:
                return "Pink"
            case .teal:
                return "Teal"
            case .orange:
                return "Orange"
        }
    }
    
    var color: Color {
        switch self {
            case .indigo:
                return .indigo
            case .pink:
                return .pink
            case .teal:
                return .teal
            case .orange:
                return .orange
        }
    }
}
