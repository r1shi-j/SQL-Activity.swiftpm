//
//  LessonView.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 12/02/2026.
//

import SwiftUI

struct LessonView: View {
    @Environment(AppSettings.self) private var settings
    
    @Binding var lesson: Lesson
    let goHome: (Bool) -> Void
    
    @State private var currentIndex = 0
    @State private var isShowingExitConfirmation = false
    @State private var isShowingCompletion = false
    @State private var isShowingAlreadyCompletedAlert: Bool
    
    @State private var counter1 = 1
    @State private var counter2 = 1
    @State private var counter3 = 1
    @State private var counter4 = 1
    @State private var counter5 = 1
    
    init(lesson: Binding<Lesson>, goHome: @escaping (Bool) -> Void) {
        _lesson = lesson
        self.goHome = goHome
        
        isShowingAlreadyCompletedAlert = _lesson.wrappedValue.isComplete
    }
    
    var body: some View {
        VStack(spacing: 12) {
            lessonProgressHeader
            
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
        .onDisappear {
            if !lesson.isComplete {
                resetLesson()
            }
        }
        .background(currentBackground.ignoresSafeArea())
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .title) {
                Text(lesson.title)
                    .fontWidth(.expanded)
            }
            ToolbarItem(placement: .navigation) {
                Button("Back", systemImage: "chevron.left", action: toggleExitConfirmation)
            }
            if currentIndex > 0 {
                if lesson.slides.indices.contains(currentIndex-1) {
                    ToolbarItem(placement: .bottomBar) {
                        if #available(iOS 26.0, *) {
                            Button("Back", action: goBack)
                                .font(.title)
                                .fontWidth(.expanded)
                                .padding(8)
                                .buttonStyle(.glassProminent)
                                .tint(settings.accentColorOption.color)
                        } else {
                            Button("Back", action: goBack)
                                .font(.title)
                                .fontWidth(.expanded)
                                .padding(8)
                                .background(settings.accentColorOption.color)
                                .clipShape(.capsule)
                                .padding()
                                .tint(settings.accentColorOption.color)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingCompletion) {
            LessonCompletionSheet(
                lessonTitle: lesson.title,
                onBackToLessons: returnToLessons,
                centerCounter: $counter5,
                topLeftCounter: $counter1,
                topRightCounter: $counter2,
                bottomLeftCounter: $counter3,
                bottomRightCounter: $counter4
            )
            .tint(settings.accentColorOption.color)
            .presentationDetents([.medium])
            .interactiveDismissDisabled()
        }
        .alert("Are you sure you want to exit this lesson?", isPresented: $isShowingExitConfirmation) {
            Button("No", role: .cancel) {}
                .tint(.primary)
            Button("Yes", role: .destructive) {
                resetLesson()
                goHome(false)
            }
        } message: {
            Text("Your progress will be lost.")
        }
        .alert("You have already completed this lesson!", isPresented: $isShowingAlreadyCompletedAlert) {
            Button("Redo Lesson", role: .destructive, action: resetLesson)
            Button("Observe Lesson") { }
            Button("Return Home", role: .cancel) { goHome(true) }
                .tint(.primary)
        } message: {
            Text("Redoing the lesson will clear your progress.\nObserve the lesson to see the answers.")
        }
    }
    
    private func advance() {
        if currentIndex + 1 < lesson.slides.count {
            withAnimation { currentIndex += 1 }
        } else {
            isShowingCompletion = true
            counter1 += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                counter4 += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                counter2 += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                counter3 += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                counter5 += 1
            }
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
    
    private func returnToLessons() {
        isShowingCompletion = false
        goHome(true)
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
            $0.activitySession.completedAnswer = nil
            $0.activitySession.completedMode = nil
        }
        lesson.isComplete = false
    }
}
