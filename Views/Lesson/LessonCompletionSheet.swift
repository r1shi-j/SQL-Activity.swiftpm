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
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(.green)

                Text("Lesson Complete")
                    .font(.title2)

                Text("Nice work! You finished \(lessonTitle).")
                    .foregroundStyle(.secondary)

                if #available(iOS 26.0, *) {
                    Button("Back to Lessons", action: onBackToLessons)
                        .buttonStyle(.glassProminent)
                } else {
                    Button("Back to Lessons", action: onBackToLessons)
                        .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .navigationTitle(lessonTitle)
        }
    }
}
