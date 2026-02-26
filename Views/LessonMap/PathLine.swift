import SwiftUI

struct PathLine: View {
    var body: some View {
        Rectangle()
            .fill(.gray.opacity(0.2))
            .frame(width: 4)
            .frame(maxHeight: .infinity)
    }
}
