import SwiftUI

struct HomeView: View {
    @Environment(AppSettings.self) private var settings
    
    @State private var lessons: [Lesson] = Lesson.defaultLessons
    @State private var path = NavigationPath()
    @State private var isShowingSettings = false
    
    var body: some View {
        NavigationStack(path: $path) {
            LessonMapView(lessons: lessons) { lesson in
                path.append(lesson)
            }
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings", systemImage: "gearshape") {
                        isShowingSettings = true
                    }
                    .tint(settings.accentColorOption.color)
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView(settings: settings)
                    .tint(settings.accentColorOption.color)
                    .presentationDetents([.fraction(0.75)])
            }
        }
    }
    
    private func handleFinish(for lesson: Lesson, success: Bool) {
        guard let currentIndex = lessons.firstIndex(where: { $0.id == lesson.id }) else { return }
        lessons[currentIndex].isComplete = success
        path = NavigationPath()
    }
}
