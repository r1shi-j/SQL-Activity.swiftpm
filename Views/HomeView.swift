import SwiftUI

struct HomeView: View {
    @State private var lessons: [Lesson] = Lesson.defaultLessons
    @State private var path = NavigationPath()
    @State private var isShowingSettings = false
    
    @AppStorage("settings.accentColor") private var accentColorRawValue = AccentColorOption.indigo.rawValue
    @AppStorage("settings.unlockAllLessons") private var unlockAllLessons = false
    @AppStorage("settings.defaultAnswerMode") private var defaultAnswerModeRawValue = AnswerMode.blocks.rawValue
    
    private var accentColorOption: AccentColorOption {
        AccentColorOption(rawValue: accentColorRawValue) ?? .indigo
    }
    
    private var defaultAnswerMode: AnswerMode {
        AnswerMode(rawValue: defaultAnswerModeRawValue) ?? .blocks
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            LessonMapView(
                lessons: lessons,
                unlockAllLessons: unlockAllLessons,
                accentColor: accentColorOption.color
            ) { lesson in
                path.append(lesson)
            }
            .navigationDestination(for: Lesson.self) { lesson in
                if let idx = lessons.firstIndex(where: { $0.id == lesson.id }) {
                    LessonView(
                        lesson: $lessons[idx],
                        defaultAnswerMode: defaultAnswerMode,
                        accentColor: accentColorOption.color
                    ) { success in
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
                    .tint(accentColorOption.color)
                }
            }
            .sheet(isPresented: $isShowingSettings) {
                SettingsView(
                    accentColorRawValue: $accentColorRawValue,
                    unlockAllLessons: $unlockAllLessons,
                    defaultAnswerModeRawValue: $defaultAnswerModeRawValue
                )
                .tint(accentColorOption.color)
                .presentationDetents([.medium, .large])
            }
        }
    }
    
    private func handleFinish(for lesson: Lesson, success: Bool) {
        guard let currentIndex = lessons.firstIndex(where: { $0.id == lesson.id }) else { return }
        lessons[currentIndex].isComplete = success
        path = NavigationPath()
    }
}
