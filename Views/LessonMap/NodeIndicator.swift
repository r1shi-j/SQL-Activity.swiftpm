import SwiftUI

struct NodeIndicator: View {
    let status: LessonMapView.Status
    let accentColor: Color
    
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
                    .strokeBorder(accentColor, lineWidth: 2)
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    private var nodeFill: Color {
        switch status {
            case .completed:
                return .green
            case .current:
                return accentColor
            case .locked:
                return .gray
        }
    }
}
