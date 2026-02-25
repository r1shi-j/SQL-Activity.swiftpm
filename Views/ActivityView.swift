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
                    Button(block.content) {
                        removeBlock(block)
                    }
                    .buttonStyle(GlassBlockButtonStyle(color: .green.opacity(0.4)))
                    .frame(height: 70)
                }
            }
            .frame(maxWidth: 800)
            
            if !session.hasBeenCompleted {
                Divider().padding(.vertical)
                
                Text("Available Blocks")
                    .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                    ForEach(availableBlocks, id: \.id) { block in
                        Button(block.content) {
                            addBlock(block)
                        }
                        .buttonStyle(GlassBlockButtonStyle(color: .red.opacity(0.4)))
                        .frame(height: 70)
                    }
                }
                .frame(maxWidth: 700)
                
                Divider().padding(.vertical)
            }
            
            //            @State private var offset = CGSize.zero
            //            @State private var movingBlock: Block? = nil
            //            LazyVGrid(
            //                columns: [GridItem(.adaptive(minimum: 130, maximum: 200))],
            //                alignment: .center,
            //                spacing: 10
            //            ) {
            //                ForEach(allBlocks, id: \.id) { block in
            //                    drawBlock(with: block.content)
            //                        .offset(x: movingBlock?.id == block.id ? offset.width : 0, y: movingBlock?.id == block.id ? offset.height : 0)
            //                        .frame(height: 70)
            //                        .gesture(
            //                            DragGesture()
            //                                .onChanged { gesture in
            //                                    offset = gesture.translation
            //                                    movingBlock = block
            //                                }
            //                                .onEnded { _ in
            //                                    withAnimation(.spring) {
            //                                        offset = .zero
            //                                        movingBlock = nil
            //                                    }
            //                                }
            //                        )
            //                }
            //            }
            //            .frame(maxWidth: 700)
            
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
    
    private func addBlock(_ block: Block) {
        guard !usedBlocks.map(\.id).contains(block.id) else { return }
        if let index = activity.initialBlocks.firstIndex(where: { $0.id == block.id }) {
            withAnimation {
                usedBlocks.append(activity.initialBlocks[index])
                availableBlocks.removeAll { $0.id == block.id }
                session.usedIndices.append(index)
            }
        }
    }
    
    private func removeBlock(_ block: Block) {
        guard !availableBlocks.map(\.id).contains(block.id) else { return }
        if let index = activity.initialBlocks.firstIndex(where: { $0.id == block.id }) {
            withAnimation {
                usedBlocks.removeAll { $0.id == block.id }
                availableBlocks.append(activity.initialBlocks[index])
                session.usedIndices.removeAll { $0 == index }
            }
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
