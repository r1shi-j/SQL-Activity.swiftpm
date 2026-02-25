//
//  ActivityView.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import Flow
import SwiftUI

struct ActivityView: View {
    let activity: Activity
    var session: ActivitySession
    let isLast: Bool
    let onCompletion: () -> Void
    
    @State private var availableBlocks: [Block]
    @State private var usedBlocks: [Block] = []
    @State private var isShowingHint = false
    
    init(activity: Activity, session: ActivitySession, isLast: Bool, onCompletion: @escaping () -> Void) {
        self.activity = activity
        self.session = session
        self.isLast = isLast
        self.onCompletion = onCompletion
        
        let used = session.usedIndices.map { activity.initialBlocks[$0] }
        self._usedBlocks = State(initialValue: used)
        
        let available = activity.initialBlocks.enumerated().filter({ !Set(session.usedIndices).contains($0.offset) }).map({ $0.element })
        self._availableBlocks = State(initialValue: available)
    }
    
    var body: some View {
        VStack {
            Text(activity.question)
                .font(.title)
                .padding()
            
            if let tip = activity.tip {
                Text(tip)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Text("Your Answer")
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                ForEach(usedBlocks, id: \.id) { block in
                    blockButton(block, color: .green.opacity(0.4)) {
                        removeBlock(block)
                    }
                    .draggable(block.id.uuidString, preview: { dragPreview(for: block) })
                    .dropDestination(for: String.self) { items, _ in
                        guard let draggedId = items.compactMap({ UUID(uuidString: $0) }).first else { return false }
                        handleDropOnUsed(draggedId: draggedId, targetId: block.id)
                        return true
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
//            .contentShape(.capsule)
            .dropDestination(for: String.self) { items, _ in
                guard let id = items.compactMap({ UUID(uuidString: $0) }).first else { return false }
                moveBlockToUsed(id: id)
                return true
            }
            
            if !session.hasBeenCompleted {
                Divider().padding(.vertical)
                
                Text("Available Blocks")
                    .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                    ForEach(availableBlocks, id: \.id) { block in
                        blockButton(block, color: .red.opacity(0.4)) {
                            addBlock(block)
                        }
                        .draggable(block.id.uuidString, preview: { dragPreview(for: block) })
                        .dropDestination(for: String.self) { items, _ in
                            guard let draggedId = items.compactMap({ UUID(uuidString: $0) }).first else { return false }
                            handleDropOnAvailable(draggedId: draggedId, targetId: block.id)
                            return true
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
//                .contentShape(.capsule)
                .dropDestination(for: String.self) { items, _ in
                    guard let id = items.compactMap({ UUID(uuidString: $0) }).first else { return false }
                    moveBlockToAvailable(id: id)
                    return true
                }
                
                Divider().padding(.vertical)
            }
            
            Spacer()
        }
        .disabled(session.wasCorrect != nil)
        .disabled(session.hasBeenCompleted)
        .background {
            switch session.wasCorrect {
                case nil: Color.blue.opacity(0.2).ignoresSafeArea()
                case true: Color.green.opacity(0.2).ignoresSafeArea()
                case false: Color.red.opacity(0.2).ignoresSafeArea()
                case .some(_): Color.clear
            }
        }
        .toolbar {
            if !session.hasBeenCompleted {
                ToolbarItem(placement: .destructiveAction) {
                    Button("Retry", systemImage: "arrow.trianglehead.counterclockwise", action: clearUserAnswer)
                        .tint(.red)
                        .disabled(session.wasCorrect != nil)
                }
                if activity.hint != nil {
//                    ToolbarSpacer(placement: .primaryAction)
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Show Hint", systemImage: "lightbulb.max.fill", action: showHint)
                            .tint(.yellow)
                            .disabled(session.wasCorrect != nil)
                    }
                }
            }
            ToolbarItem(placement: .bottomBar) {
                let (title, action, color): (String, () -> Void, Color) = switch session.wasCorrect {
                    case nil: ("Submit", verifyAnswer, .blue)
                    case true: (isLast ? "Finish" : "Next", nextSlide, .green)
                    case false: ("Retry", retryQuestion, .red)
                    case .some(_): ("Oops", verifyAnswer, .primary)
                }
                if #available(iOS 26.0, *) {
                    Button(title, action: action)
                        .font(.title)
                        .padding(8)
                        .buttonStyle(.glassProminent)
                        .tint(color)
                } else {
                    Button(title, action: action)
                        .font(.title)
                        .padding(8)
                        .background(color)
                        .clipShape(.capsule)
                        .padding()
                        .tint(.primary)
                }
                // bouncy animation if wasCorrect != nil
            }
        }
        .alert(activity.hint ?? "", isPresented: $isShowingHint) {}
    }
    
    private func blockButton(_ block: Block, color: Color, action: @escaping () -> Void) -> some View {
        Button(block.content, action: action)
            .buttonStyle(GlassBlockButtonStyle(color: color))
            .contentShape(.capsule)
            .frame(height: 70)
            .onTapGesture(perform: action)
    }
    
    private func dragPreview(for block: Block) -> some View {
        Text(block.content)
            .font(.title3)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.15))
            .clipShape(.capsule)
    }
    
    private func addBlock(_ block: Block) {
        moveBlockToUsed(id: block.id)
    }
    
    private func removeBlock(_ block: Block) {
        moveBlockToAvailable(id: block.id)
    }
    
    private func handleDropOnUsed(draggedId: UUID, targetId: UUID) {
        if usedBlocks.contains(where: { $0.id == draggedId }) {
            reorderUsedBlocks(draggedId: draggedId, targetId: targetId)
        } else {
            moveBlockToUsed(id: draggedId)
        }
    }
    
    private func handleDropOnAvailable(draggedId: UUID, targetId: UUID) {
        if availableBlocks.contains(where: { $0.id == draggedId }) {
            return
        }
        moveBlockToAvailable(id: draggedId)
    }
    
    private func moveBlockToUsed(id: UUID) {
        guard !usedBlocks.contains(where: { $0.id == id }) else { return }
        guard let sourceIndex = availableBlocks.firstIndex(where: { $0.id == id }) else { return }
        
        withAnimation {
            let block = availableBlocks.remove(at: sourceIndex)
            usedBlocks.append(block)
            syncSessionUsedIndices()
        }
    }
    
    private func moveBlockToAvailable(id: UUID) {
        guard !availableBlocks.contains(where: { $0.id == id }) else { return }
        guard let sourceIndex = usedBlocks.firstIndex(where: { $0.id == id }) else { return }
        
        withAnimation {
            let block = usedBlocks.remove(at: sourceIndex)
            availableBlocks.append(block)
            syncSessionUsedIndices()
        }
    }
    
    private func reorderUsedBlocks(draggedId: UUID, targetId: UUID) {
        guard let fromIndex = usedBlocks.firstIndex(where: { $0.id == draggedId }),
              let toIndex = usedBlocks.firstIndex(where: { $0.id == targetId }),
              fromIndex != toIndex else { return }
        
        withAnimation {
            let block = usedBlocks.remove(at: fromIndex)
            usedBlocks.insert(block, at: toIndex)
            syncSessionUsedIndices()
        }
    }
    
    private func syncSessionUsedIndices() {
        session.usedIndices = usedBlocks.compactMap { block in
            activity.initialBlocks.firstIndex(where: { $0.id == block.id })
        }
    }
    
    private func showHint() {
        isShowingHint = true
    }
    
    private func clearUserAnswer() {
        guard availableBlocks != activity.initialBlocks else { return }
        withAnimation {
            session.usedIndices.removeAll()
            availableBlocks = activity.initialBlocks
            usedBlocks = []
        }
    }
    
    private func verifyAnswer() {
        let userAnswer = usedBlocks.map(\.content).joined(separator: " ")
        
        withAnimation {
            session.wasCorrect = userAnswer == activity.answer
        }
    }
    
    private func retryQuestion() {
        clearUserAnswer()
        withAnimation {
            session.wasCorrect = nil
        }
    }
    
    private func nextSlide() {
        withAnimation {
            session.hasBeenCompleted = true
            onCompletion()
        }
    }
}
