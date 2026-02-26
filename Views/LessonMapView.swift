//
//  LessonMapView.swift
//  SQL Activity
//
//  Created by Codex on 26/02/2026.
//

import SwiftUI

struct LessonMapView: View {
    let lessons: [Lesson]
    let onSelectLesson: (Lesson) -> Void

    struct MapLesson: Identifiable {
        let id: UUID
        let title: String
        let subtitle: String
        let status: Status
        let side: Side
        let lesson: Lesson
    }

    enum Status {
        case completed
        case current
        case locked
    }

    enum Side {
        case left
        case right
    }

    private var mapLessons: [MapLesson] {
        let firstIncompleteIndex = lessons.firstIndex(where: { !$0.isComplete }) ?? lessons.count

        return lessons.enumerated().map { index, lesson in
            let status: Status
            if lesson.isComplete || index < firstIncompleteIndex {
                status = .completed
            } else if index == firstIncompleteIndex {
                status = .current
            } else {
                status = .locked
            }

            return MapLesson(
                id: lesson.id,
                title: lesson.title,
                subtitle: lesson.subtitle ?? "Lesson \(index + 1)",
                status: status,
                side: index.isMultiple(of: 2) ? .left : .right,
                lesson: lesson
            )
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Your SQL Journey")
                    .font(.largeTitle)
                    .fontWidth(.expanded)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                ZStack(alignment: .top) {
                    PathLine()

                    VStack(spacing: 36) {
                        ForEach(mapLessons) { lesson in
                            LessonNodeView(lesson: lesson) {
                                onSelectLesson(lesson.lesson)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal, 16)
        }
        .background(AppTheme.infoBackground.ignoresSafeArea())
    }
}

private struct LessonNodeView: View {
    let lesson: LessonMapView.MapLesson
    let action: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            if lesson.side == .left {
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    LessonCard(lesson: lesson, action: action)
                        .frame(maxWidth: 220)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)

                NodeIndicator(status: lesson.status)
                    .frame(width: 40)

                Color.clear
                    .frame(maxWidth: .infinity)
            } else {
                Color.clear
                    .frame(maxWidth: .infinity)

                NodeIndicator(status: lesson.status)
                    .frame(width: 40)

                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    LessonCard(lesson: lesson, action: action)
                        .frame(maxWidth: 220)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

private struct LessonCard: View {
    let lesson: LessonMapView.MapLesson
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 6) {
                Text(lesson.title)
                    .font(.headline)
                Text(lesson.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(12)
            .frame(maxWidth: 220, alignment: .leading)
            .background(cardBackground)
            .clipShape(.rect(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(borderColor, lineWidth: lesson.status == .current ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .opacity(lesson.status == .locked ? 0.6 : 1)
        .disabled(lesson.status == .locked)
    }

    private var cardBackground: Color {
        switch lesson.status {
        case .completed:
            return .green.opacity(0.12)
        case .current:
            return .blue.opacity(0.12)
        case .locked:
            return .gray.opacity(0.08)
        }
    }

    private var borderColor: Color {
        switch lesson.status {
        case .completed:
            return .green
        case .current:
            return .blue
        case .locked:
            return .gray
        }
    }
}

private struct NodeIndicator: View {
    let status: LessonMapView.Status

    var body: some View {
        ZStack {
            Circle()
                .fill(nodeFill)
                .frame(width: 22, height: 22)
            if status == .completed {
                Image(systemName: "checkmark")
                    .font(.caption)
                    .foregroundStyle(.white)
            } else if status == .current {
                Circle()
                    .strokeBorder(.blue, lineWidth: 2)
                    .frame(width: 30, height: 30)
            }
        }
    }

    private var nodeFill: Color {
        switch status {
        case .completed:
            return .green
        case .current:
            return .blue
        case .locked:
            return .gray
        }
    }
}

private struct PathLine: View {
    var body: some View {
        Rectangle()
            .fill(.gray.opacity(0.2))
            .frame(width: 4)
            .frame(maxHeight: .infinity)
    }
}
