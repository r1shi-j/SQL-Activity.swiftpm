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
                            ActivityView(activity: activity, isLast: currentIndex + 1 == lesson.slides.count) {
                                lesson.slides[currentIndex].isComplete = true
                                advance()
                            }
                            .id(activity.id)
                        case .info(let info):
                            InfoView(info: info) {
                                lesson.slides[currentIndex].isComplete = true
                                advance()
                            }
                            .id(info.id)
                    }
                }
//                HStack {
//                    if currentIndex > 0 {
//                        Button("Back") {goBack()}
//                    }
//                    Spacer()
//                    if slide.isComplete {
//                        Button(currentIndex + 1 == slides.count ? "Finish" : "Next") {}
//                    }
//                }
            } else {
                ContentUnavailableView("No content", systemImage: "rectangle.on.rectangle.slash", description: Text("There appears to be no content here. Try again later."))
            }
        }
        .navigationTitle(lesson.title)
        .navigationSubtitle(lesson.subtitle ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("Back", systemImage: "chevron.left", action: toggleExitConfirmation)
            }
        }
        .alert("Are you sure you want you want to exit this lesson?", isPresented: $isShowingExitConfirmation) {
            Button("No", role: .cancel) {}
            Button("Yes", role: .destructive) { goHome(false) }
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
    
    private func toggleExitConfirmation() {
        isShowingExitConfirmation = true
    }
}

