import SwiftUI

struct OnboardingView: View {
    let onFinish: () -> Void
    
    @State private var currentPage = 0
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Welcome to SQL Activity",
            subtitle: "Learn SQL by building real queries from simple blocks.",
            systemImage: "graduationcap.fill"
        ),
        OnboardingPage(
            title: "Build Queries",
            subtitle: "Tap or drag blocks into the answer area, then check if your SQL is correct.",
            systemImage: "square.grid.3x3.fill"
        ),
        OnboardingPage(
            title: "Progress Through Lessons",
            subtitle: "Complete activities to unlock more lessons on the map and strengthen your SQL skills.",
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
