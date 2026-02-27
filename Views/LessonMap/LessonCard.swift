import SwiftUI

struct LessonCard: View {
    @Environment(AppSettings.self) private var settings
    
    let lesson: LessonMapView.MapLesson
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 6) {
                Text(lesson.title)
                    .font(.headline)
                Text(lesson.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(12)
            .frame(maxWidth: 220, alignment: .leading)
            .background(cardBackground)
            .clipShape(.rect(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(borderColor, lineWidth: lesson.status == .current ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .opacity(lesson.status == .locked ? 0.6 : 1)
        .disabled(lesson.status == .locked)
    }
    
    private var cardBackground: Color {
        switch lesson.status {
            case .completed:
                return .green.opacity(0.12)
            case .current:
                return settings.accentColorOption.color.opacity(0.12)
            case .locked:
                return .gray.opacity(0.08)
        }
    }
    
    private var borderColor: Color {
        switch lesson.status {
            case .completed:
                return .green
            case .current:
                return settings.accentColorOption.color
            case .locked:
                return .gray
        }
    }
}
