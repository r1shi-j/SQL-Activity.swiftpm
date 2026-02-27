import SwiftUI

struct LessonNodeView: View {
    let lesson: LessonMapView.MapLesson
    let transitionNamespace: Namespace.ID
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            if lesson.side == .left {
                HStack(spacing: 0) {
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    Spacer(minLength: 0)
                    animatedLessonCard
                        .frame(maxWidth: 220)
                    Spacer(minLength: 0)
                        .overlay {
                            connectorLine
                        }
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
                        .overlay {
                            connectorLine
                        }
                    animatedLessonCard
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
    
    @ViewBuilder
    private var animatedLessonCard: some View {
        let emergeOffset = lesson.side == .left ? 46.0 : -46.0
        LessonCard(
            lesson: lesson,
            transitionNamespace: transitionNamespace,
            action: action
        )
        .scrollTransition(.animated(.bouncy(duration: 0.5)), axis: .vertical) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.2)
                .scaleEffect(phase.isIdentity ? 1 : 0.82)
                .offset(x: phase.isIdentity ? 0 : emergeOffset)
        }
    }
    
    private var connectorLine: some View {
        Rectangle()
            .fill(.gray.opacity(0.2))
            .frame(height: 2)
    }
}
