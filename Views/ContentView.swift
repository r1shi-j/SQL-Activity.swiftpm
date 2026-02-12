import SwiftUI

struct ContentView: View {
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
                                switch lesson.status {
                                    case .notStarted:
                                        Image(systemName: "minus")
                                            .foregroundStyle(.gray)
                                    case .complete:
                                        Image(systemName: "checkmark.seal.fill")
                                            .foregroundStyle(.green)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Lessons")
            .navigationDestination(for: Lesson.self) { lesson in
                ActivityView(lesson: lesson) { route in
                    handleFinish(for: lesson, route: route)
                }
                .id(lesson.id)
            }
        }
    }
    
    private func handleFinish(for lesson: Lesson, route: ActivityRoute) {
        guard let currentIndex = lessons.firstIndex(where: { $0.id == lesson.id }) else { return }
        lessons[currentIndex].status = .complete
        
        switch route {
            case .home:
                navigateHome()
            case .next:
                navigateToNextLesson(currentIndex: currentIndex)
        }
    }
    
    private func navigateHome() {
        path = NavigationPath()
    }
    
    private func navigateToNextLesson(currentIndex: Array<Lesson>.Index) {
        let nextIndex = lessons.index(after: currentIndex)
         
        if nextIndex < lessons.count {
            path.removeLast()
            path.append(lessons[nextIndex])
        } else {
            path = NavigationPath()
        }
    }
}

