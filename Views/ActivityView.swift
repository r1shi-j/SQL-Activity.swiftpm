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
    let isLast: Bool
    let onCompletion: () -> Void
    
    let initialBlocks: [Block]
    @State private var allBlocks: [Block]
    @State private var usedBlocks: [Block] = []
    
    @State private var isShowingHint = false
    @State private var wasCorrect: Bool?
    
    init(activity: Activity, isLast: Bool, onCompletion: @escaping () -> Void) {
        self.activity = activity
        self.isLast = isLast
        self.onCompletion = onCompletion
        
        let newBlocks = activity.blocks.map {
            Block(content: $0)
        }
        initialBlocks = newBlocks
        _allBlocks = State(initialValue: newBlocks)
    }
    
    var body: some View {
        VStack {
            Text(activity.question)
                .font(.title)
                .padding()
            
            Spacer()
            
            Text("Your Answer")
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                ForEach(usedBlocks, id: \.id) { block in
                    Button(block.content) {
                        withAnimation {
                            if let removeIndex = usedBlocks.firstIndex(where: { $0.id == block.id }) {
                                var moved = usedBlocks.remove(at: removeIndex)
                                moved.isUsed = false
                                allBlocks.append(moved)
                            }
                        }
                    }
                    .buttonStyle(GlassBlockButtonStyle(color: .green.opacity(0.4)))
                    .frame(height: 70)
                }
            }
            .frame(maxWidth: 800)
            
            Divider().padding(.vertical)
            
            Text("Available Blocks")
                .font(.headline).frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                ForEach(allBlocks, id: \.id) { block in
                    Button(block.content) {
                        withAnimation {
                            if let index = allBlocks.firstIndex(where: { $0.id == block.id }) {
                                var moved = allBlocks.remove(at: index)
                                moved.isUsed = true
                                usedBlocks.append(moved)
                            }
                        }
                    }
                    .buttonStyle(GlassBlockButtonStyle(color: .red.opacity(0.4)))
                    .frame(height: 70)
                }
            }
            .frame(maxWidth: 700)
            
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
            
            Divider().padding(.vertical)
            
            Spacer()
        }
        .background {
            switch wasCorrect {
                case nil: Color.blue.opacity(0.2).ignoresSafeArea()
                case true: Color.green.opacity(0.2).ignoresSafeArea()
                case false: Color.red.opacity(0.2).ignoresSafeArea()
            }
        }
        .disabled(wasCorrect != nil)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Retry", systemImage: "arrow.trianglehead.counterclockwise", action: clearUserAnswer)
                    .tint(.red)
                    .disabled(wasCorrect != nil)
            }
            if activity.hint != nil {
                ToolbarSpacer(placement: .primaryAction)
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Show Hint", systemImage: "lightbulb.max.fill", action: showHint)
                        .tint(.yellow)
                        .disabled(wasCorrect != nil)
                }
            }
            ToolbarItem(placement: .bottomBar) {
                let (title, action, color): (String, () -> Void, Color) = switch wasCorrect {
                    case nil: ("Submit", verifyAnswer, .blue)
                    case true: (isLast ? "Finish" : "Next", nextQuestion, .green)
                    case false: ("Retry", retryQuestion, .red)
                }
                Button(title, role: .confirm, action: action)
                    .font(.title)
                    .padding(8)
                    .buttonStyle(.glassProminent)
                    .tint(color)
            }
        }
        .alert(activity.hint ?? "", isPresented: $isShowingHint) {}
    }
    
    private func showHint() {
        isShowingHint = true
    }
    
    private func clearUserAnswer() {
        guard allBlocks != initialBlocks else { return }
        withAnimation {
            allBlocks = initialBlocks
            usedBlocks = []
        }
    }
    
    private func verifyAnswer() {
        let userAnswer = usedBlocks.map(\.content).joined(separator: " ")
        
        withAnimation {
            if userAnswer == activity.answer {
                wasCorrect = true
            } else {
                wasCorrect = false
            }
        }
    }
    
    private func nextQuestion() {
        onCompletion()
    }
    
    private func retryQuestion() {
        clearUserAnswer()
        withAnimation {
            wasCorrect = nil
        }
    }
}
