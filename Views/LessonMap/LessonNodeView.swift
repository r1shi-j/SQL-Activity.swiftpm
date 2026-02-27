import SwiftUI

struct LessonNodeView: View {
    let lesson: LessonMapView.MapLesson
    let action: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            if lesson.side == .left {
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    LessonCard(lesson: lesson, action: action)
                        .frame(maxWidth: 220)
                    Spacer(minLength: 0)
                        .overlay {
                            connectorLine
                        }
                }
                .frame(maxWidth: .infinity)

                NodeIndicator(status: lesson.status)
                    .frame(width: 40)

                Color.clear
                    .frame(maxWidth: .infinity)
            } else {
                Color.clear
                    .frame(maxWidth: .infinity)

                NodeIndicator(status: lesson.status)
                    .frame(width: 40)

                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                        .overlay {
                            connectorLine
                        }
                    LessonCard(lesson: lesson, action: action)
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

    private var connectorLine: some View {
        Rectangle()
            .fill(.gray.opacity(0.2))
            .frame(height: 2)
    }
}
