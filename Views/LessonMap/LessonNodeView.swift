import SwiftUI

struct LessonNodeView: View {
    let lesson: LessonMapView.MapLesson
    let accentColor: Color
    let action: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            if lesson.side == .left {
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    LessonCard(lesson: lesson, accentColor: accentColor, action: action)
                        .frame(maxWidth: 220)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)

                NodeIndicator(status: lesson.status, accentColor: accentColor)
                    .frame(width: 40)

                Color.clear
                    .frame(maxWidth: .infinity)
            } else {
                Color.clear
                    .frame(maxWidth: .infinity)

                NodeIndicator(status: lesson.status, accentColor: accentColor)
                    .frame(width: 40)

                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    LessonCard(lesson: lesson, accentColor: accentColor, action: action)
                        .frame(maxWidth: 220)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
