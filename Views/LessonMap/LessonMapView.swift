import SwiftUI

struct LessonMapView: View {
    let lessons: [Lesson]
    let unlockAllLessons: Bool
    let accentColor: Color
    let onSelectLesson: (Lesson) -> Void

    struct MapLesson: Identifiable {
        let id: UUID
        let title: String
        let subtitle: String
        let status: Status
        let side: Side
        let lesson: Lesson
    }

    enum Status {
        case completed
        case current
        case locked
    }

    enum Side {
        case left
        case right
    }

    private var mapLessons: [MapLesson] {
        let firstIncompleteIndex = lessons.firstIndex(where: { !$0.isComplete }) ?? lessons.count

        return lessons.enumerated().map { index, lesson in
            let status: Status
            if lesson.isComplete {
                status = .completed
            } else if unlockAllLessons || index == firstIncompleteIndex {
                status = .current
            } else {
                status = .locked
            }

            return MapLesson(
                id: lesson.id,
                title: lesson.title,
                subtitle: lesson.subtitle ?? "Lesson \(index + 1)",
                status: status,
                side: index.isMultiple(of: 2) ? .left : .right,
                lesson: lesson
            )
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Your SQL Journey")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                    .bold()
                    .padding(.top, 50)

                ZStack(alignment: .top) {
                    PathLine()

                    VStack(spacing: 36) {
                        ForEach(mapLessons) { lesson in
                            LessonNodeView(lesson: lesson, accentColor: accentColor) {
                                onSelectLesson(lesson.lesson)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal, 16)
        }
        .background(AppTheme.infoBackground.ignoresSafeArea())
    }
}
