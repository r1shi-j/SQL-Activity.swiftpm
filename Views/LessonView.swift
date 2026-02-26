//
//  LessonView.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import SwiftUI

//enum ActivityRoute {
//    case next
//    case home
//}

struct LessonView: View {
    @Binding var lesson: Lesson
    let goHome: (Bool/*ActivityRoute*/) -> Void
    
    @State private var currentIndex = 0
    @State private var isShowingExitConfirmation = false
    
    init(lesson: Binding<Lesson>, goHome: @escaping (Bool/*ActivityRoute*/) -> Void) {
        _lesson = lesson
        self.goHome = goHome
    }
    
    var body: some View {
        VStack {
            if lesson.slides.indices.contains(currentIndex) {
                let slide = lesson.slides[currentIndex]
                Group {
                    switch slide.kind {
                        case .activity(let activity):
                            ActivityView(
                                activity: activity,
                                session: lesson.slides[currentIndex].activitySession,
                                isLast: currentIndex + 1 == lesson.slides.count
                            ) {
                                lesson.slides[currentIndex].isComplete = true
                                advance()
                            }
                            .id(activity.id)
                        case .info(let info):
                            InfoView(info: info, isLast: currentIndex + 1 == lesson.slides.count) {
                                lesson.slides[currentIndex].isComplete = true
                                advance()
                            }
                            .id(info.id)
                    }
                }
            } else {
                ContentUnavailableView("No content", systemImage: "rectangle.on.rectangle.slash", description: Text("There appears to be no content here. Try again later."))
            }
        }
        .background(currentBackground.ignoresSafeArea())
        .navigationTitle(lesson.title)
//        .navigationSubtitle(lesson.subtitle ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("Back", systemImage: "chevron.left", action: toggleExitConfirmation)
            }
            if currentIndex > 0 {
                if lesson.slides.indices.contains(currentIndex-1) {
                    ToolbarItem(placement: .bottomBar) {
                        if #available(iOS 26.0, *) {
                            Button("Back", action: goBack)
                                .font(.title)
                                .padding(8)
                                .buttonStyle(.glassProminent)
                                .tint(.indigo)
                        } else {
                            Button("Back", action: goBack)
                                .font(.title)
                                .padding(8)
                                .background(.indigo)
                                .clipShape(.capsule)
                                .padding()
                                .tint(.primary)
                        }
                    }
                }
            }
        }
        .alert("Are you sure you want to exit this lesson?", isPresented: $isShowingExitConfirmation) {
            Button("No", role: .cancel) {}
            Button("Yes", role: .destructive) {
                resetLesson()
                goHome(false)
            }
        } message: {
            Text("Your progress will be lost.")
        }
    }
    
    private func advance() {
        if currentIndex + 1 < lesson.slides.count {
            withAnimation { currentIndex += 1 }
        } else {
            goHome(true)
        }
    }
    
    private func goBack() {
        if currentIndex > 0 {
            withAnimation { currentIndex -= 1 }
        }
    }
    
private var lessonProgressHeader: some View {
    ProgressView(value: Double(currentIndex + 1), total: Double(max(lesson.slides.count, 1)))
        .tint(.blue)
        .padding(.horizontal)
}
    
    private var currentBackground: Color {
        guard lesson.slides.indices.contains(currentIndex) else { return AppTheme.activityBackground }
        switch lesson.slides[currentIndex].kind {
            case .activity:
                switch lesson.slides[currentIndex].activitySession.wasCorrect {
                    case nil: return AppTheme.activityBackground
                    case true: return AppTheme.successBackground
                    case false: return AppTheme.errorBackground
                    case .some(_): return AppTheme.activityBackground
                }
            case .info:
                return AppTheme.infoBackground
        }
    }
    
private var completionSheet: some View {
    NavigationStack {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 48))
                .foregroundStyle(.green)
            Text("Lesson Complete")
                .font(.title2)
            Text("Nice work! You finished \(lesson.title).")
                .foregroundStyle(.secondary)
            if #available(iOS 26.0, *) {
                Button("Back to Lessons") {
                    isShowingCompletion = false
                    goHome(true)
                }
                .buttonStyle(.glassProminent)
            } else {
                Button("Back to Lessons") {
                    isShowingCompletion = false
                    goHome(true)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .navigationTitle(lesson.title)
    }
}
    
    private func toggleExitConfirmation() {
        if lesson.isComplete == true {
            goHome(true)
        } else {
            isShowingExitConfirmation = true
        }
    }
    
    private func resetLesson() {
        lesson.slides.forEach {
            $0.activitySession.usedIndices.removeAll()
            $0.activitySession.wasCorrect = nil
            $0.activitySession.hasBeenCompleted = false
        }
    }
}

