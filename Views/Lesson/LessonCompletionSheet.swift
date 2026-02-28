//
//  LessonCompletionSheet.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 26/02/2026.
//

import ConfettiSwiftUI
import SwiftUI

struct LessonCompletionSheet: View {
    let lessonTitle: String
    let onBackToLessons: () -> Void
    
    @Binding var centerCounter: Int
    @Binding var topLeftCounter: Int
    @Binding var topRightCounter: Int
    @Binding var bottomLeftCounter: Int
    @Binding var bottomRightCounter: Int
    
    var body: some View {
        ZStack {
            completionContent
            ConfettiCannon(
                trigger: $centerCounter,
                num: 80,
                confettiSize: 14,
                openingAngle: .degrees(0),
                closingAngle: .degrees(360),
                radius: 300
            )
            
            VStack {
                HStack {
                    ConfettiCannon(
                        trigger: $topLeftCounter,
                        num: 20,
                        confettiSize: 14,
                        openingAngle: .degrees(0),
                        closingAngle: .degrees(360),
                        radius: 200
                    )
                    Spacer()
                    ConfettiCannon(
                        trigger: $topRightCounter,
                        num: 20,
                        confettiSize: 14,
                        openingAngle: .degrees(0),
                        closingAngle: .degrees(360),
                        radius: 200
                    )
                }
                Spacer()
                HStack {
                    ConfettiCannon(
                        trigger: $bottomLeftCounter,
                        num: 20,
                        confettiSize: 14,
                        openingAngle: .degrees(0),
                        closingAngle: .degrees(360),
                        radius: 200
                    )
                    Spacer()
                    ConfettiCannon(
                        trigger: $bottomRightCounter,
                        num: 20,
                        confettiSize: 14,
                        openingAngle: .degrees(0),
                        closingAngle: .degrees(360),
                        radius: 200
                    )
                }
            }
            .frame(width: 200, height: 200, alignment: .center)
        }
    }
    
    private var completionContent: some View {
        NavigationStack {
            VStack(spacing: 16) {
                completionBadge
                
                Text("Lesson Complete")
                    .font(.title2)
                    .fontWidth(.expanded)
                
                Text("Nice work! You finished \(lessonTitle).")
                    .foregroundStyle(.secondary)
                
                if #available(iOS 26.0, *) {
                    Button("Back to Lessons", action: onBackToLessons)
                        .buttonStyle(.glassProminent)
                        .fontWidth(.expanded)
                } else {
                    Button("Back to Lessons", action: onBackToLessons)
                        .buttonStyle(.borderedProminent)
                        .fontWidth(.expanded)
                }
            }
            .padding()
            .padding(.bottom, 40)
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text(lessonTitle)
                        .fontWidth(.expanded)
                }
            }
        }
        .background(AppTheme.successBackground.opacity(0.3).ignoresSafeArea())
    }
    
    private var completionBadge: some View {
        Image(systemName: "checkmark.seal.fill")
            .font(.system(size: 48))
            .foregroundStyle(.green)
            .keyframeAnimator(
                initialValue: CompletionBadgeAnimationValues(),
                trigger: centerCounter
            ) { content, value in
                content
                    .scaleEffect(value.scale)
                    .offset(y: value.offsetY)
                    .rotationEffect(value.rotation)
            } keyframes: { _ in
                KeyframeTrack(\.scale) {
                    CubicKeyframe(0.9, duration: 0.08)
                    SpringKeyframe(1.16, duration: 0.24, spring: .bouncy)
                    SpringKeyframe(1.0, duration: 0.22, spring: .snappy)
                }
                
                KeyframeTrack(\.offsetY) {
                    CubicKeyframe(8, duration: 0.08)
                    SpringKeyframe(-8, duration: 0.24, spring: .bouncy)
                    SpringKeyframe(0, duration: 0.22, spring: .snappy)
                }
                
                KeyframeTrack(\.rotation) {
                    CubicKeyframe(.degrees(-6), duration: 0.08)
                    SpringKeyframe(.degrees(6), duration: 0.24, spring: .bouncy)
                    SpringKeyframe(.degrees(0), duration: 0.22, spring: .snappy)
                }
            }
    }
}

private struct CompletionBadgeAnimationValues {
    var scale: CGFloat = 1.0
    var offsetY: CGFloat = 0
    var rotation: Angle = .zero
}
