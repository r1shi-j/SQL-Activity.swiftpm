import SwiftUI

struct HomeView: View {
    @State private var lessons: [Lesson] = Lesson.defaultLessons
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(lessons) { lesson in
                    NavigationLink(value: lesson) {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(lesson.title).font(.headline)
                                    if let subtitle = lesson.subtitle {
                                        Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
                                    }
                                }
                                Spacer()
                                if lesson.isComplete {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundStyle(.green)
                                } else {
                                    Image(systemName: "minus")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Lessons")
            .navigationDestination(for: Lesson.self) { lesson in
                if let idx = lessons.firstIndex(where: { $0.id == lesson.id }) {
                    LessonView(lesson: $lessons[idx]) { success in
                        handleFinish(for: lessons[idx], success: success)
                    }
                    .id(lesson.id)
                } else {
                    Text("Lesson not found")
                }
            }
        }
    }
    
    private func handleFinish(for lesson: Lesson, success: Bool) {
        guard let currentIndex = lessons.firstIndex(where: { $0.id == lesson.id }) else { return }
        lessons[currentIndex].isComplete = success
        path = NavigationPath()
    }
}
