import SwiftUI

struct HomeView: View {
    @Environment(AppSettings.self) private var settings
    
    @Namespace private var lessonTransitionNamespace
    
    @State private var lessons: [Lesson] = Lesson.defaultLessons
    @State private var path = NavigationPath()
    @State private var isShowingSettings = false
    @State private var isShowingOnboarding = false
    
    var body: some View {
        NavigationStack(path: $path) {
            LessonMapView(
                lessons: lessons,
                transitionNamespace: lessonTransitionNamespace
            ) { lesson in
                path.append(lesson)
            }
            .background {
                MeshGradient(
                    width: 3, height: 3, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [0.5, 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [
                        .green.opacity(0.3), .teal.opacity(0.3), .green.opacity(0.3),
                        .green.opacity(0.3), .yellow.opacity(0.3), .green.opacity(0.3),
                        .orange.opacity(0.3), .red.opacity(0.3), .orange.opacity(0.3)
                    ]
                ).ignoresSafeArea()
            }
            .navigationDestination(for: Lesson.self) { lesson in
                if let idx = lessons.firstIndex(where: { $0.id == lesson.id }) {
                    LessonView(lesson: $lessons[idx]) { success in
                        handleFinish(for: lessons[idx], success: success)
                    }
                    .id(lesson.id)
                    .navigationTransition(.zoom(sourceID: lesson.id, in: lessonTransitionNamespace))
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
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(settings: settings) {
                isShowingOnboarding = true
            }
            .tint(settings.accentColorOption.color)
            .presentationDetents([.fraction(0.9)])
        }
        .fullScreenCover(isPresented: $isShowingOnboarding) {
            OnboardingView {
                isShowingOnboarding = false
            }
            .tint(settings.accentColorOption.color)
        }
        .task {
            guard settings.hasSeenOnboarding == false else { return }
            settings.hasSeenOnboarding = true
            isShowingOnboarding = true
        }
    }
    
    private func handleFinish(for lesson: Lesson, success: Bool) {
        guard let currentIndex = lessons.firstIndex(where: { $0.id == lesson.id }) else { return }
        lessons[currentIndex].isComplete = success
        path = NavigationPath()
    }
}
