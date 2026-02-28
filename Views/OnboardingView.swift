//
//  OnboardingView.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 27/02/2026.
//

import SwiftUI

struct OnboardingView: View {
    let onFinish: () -> Void
    
    @State private var currentPage = 0
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Welcome to Learn SQL",
            subtitle: "This app teaches SQL by letting you build real queries step by step, like solving mini puzzles.",
            systemImage: "graduationcap.fill"
        ),
        OnboardingPage(
            title: "What Is SQL?",
            subtitle: "SQL is the language used to read and manage data in databases. You will learn commands like SELECT, WHERE, ORDER BY, INSERT, UPDATE, and JOIN.",
            systemImage: "server.rack"
        ),
        OnboardingPage(
            title: "Learn In Small Steps",
            subtitle: "Lessons mix short teaching slides with activities, so you learn one idea, practice it, then build on it.",
            systemImage: "list.bullet.rectangle.portrait"
        ),
        OnboardingPage(
            title: "Build Queries With Blocks",
            subtitle: "Tap a block to move it between areas, or drag any block to place it exactly where you want in your answer.",
            systemImage: "square.grid.3x3.fill"
        ),
        OnboardingPage(
            title: "Use Hints and Feedback",
            subtitle: "If you get stuck, open a hint. If your answer is wrong, review feedback and adjust your query like a real SQL debugger.",
            systemImage: "lightbulb.max.fill"
        ),
        OnboardingPage(
            title: "Meet the AI Analyzer",
            subtitle: "When an answer is incorrect, the AI analyzer explains likely mistakes, compares your query to expected SQL, and suggests what to fix next.",
            systemImage: "brain.head.profile"
        ),
        OnboardingPage(
            title: "Progress Through The Map",
            subtitle: "Complete activities to unlock more lessons, tackle harder schemas, and move from beginner queries to multi-table thinking.",
            systemImage: "map.fill"
        )
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                            .padding(.horizontal, 28)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(spacing: 12) {
                    if currentPage < pages.count - 1 {
                        Button("Next") {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    } else {
                        Button("Start Learning") {
                            onFinish()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    Button("Skip") {
                        onFinish()
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                }
                .padding(.bottom, 12)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled()
    }
}

private struct OnboardingPage: Equatable {
    let title: String
    let subtitle: String
    let systemImage: String
}

private struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            animatedHeroIcon
            
            Text(page.title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Text(page.subtitle)
                .font(.title3)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
    
    private var animatedHeroIcon: some View {
        iconBase
            .phaseAnimator([0, 1, 2]) { content, phase in
                content
                    .scaleEffect(phase == 1 ? 1.08 : 1.0)
                    .offset(y: phase == 2 ? -4 : 0)
            } animation: { phase in
                switch phase {
                    case 0:
                            .smooth(duration: 0.9)
                    case 1:
                            .bouncy(duration: 0.7)
                    case 2:
                            .easeInOut(duration: 0.7)
                    default:
                            .default
                }
            }
    }
    
    private var iconBase: some View {
        Image(systemName: page.systemImage)
            .font(.system(size: 64))
            .foregroundStyle(.tint)
            .frame(width: 120, height: 120)
            .background(.tint.opacity(0.16), in: Circle())
    }
}
