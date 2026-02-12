//
//  ActivityView.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import Flow
import SwiftUI

enum ActivityRoute {
    case next
    case home
}

struct ActivityView: View {
    let lesson: Lesson
    let onFinish: (ActivityRoute) -> Void
    
    let initialBlocks: [Block]
    @State private var allBlocks: [Block]
    @State private var usedBlocks: [Block] = []
    
    init(lesson: Lesson, onFinish: @escaping (ActivityRoute) -> Void) {
        self.lesson = lesson
        self.onFinish = onFinish
        
        let newBlocks = lesson.blocks.map {
            Block(content: $0)
        }
        initialBlocks = newBlocks
        _allBlocks = State(initialValue: newBlocks)
    }
    
    @State private var isShowingHint = false
    @State private var isShowingResult = false
    @State private var resultMessage = ""
    @State private var wasCorrect = false
    
    var body: some View {
        VStack {
            Text(lesson.question)
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
        .navigationTitle(lesson.title)
        .navigationSubtitle(lesson.subtitle ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Retry", systemImage: "arrow.trianglehead.counterclockwise", action: clearUserAnswer)
                    .tint(.red)
            }
            if lesson.hint != nil {
                ToolbarSpacer(placement: .primaryAction)
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Show Hint", systemImage: "lightbulb.max.fill", action: showHint)
                        .tint(.yellow)
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Button("Submit", role: .confirm, action: verifyAnswer)
                    .font(.title)
                    .padding(8)
                    .buttonStyle(.glassProminent)
                    .tint(.blue)
            }
        }
        .alert(lesson.hint ?? "", isPresented: $isShowingHint) {}
        .alert(resultMessage, isPresented: $isShowingResult) {
            if wasCorrect {
                Button("Home", role: .cancel) { onFinish(.home) }
                Button("Next Activity", role: .confirm) { onFinish(.next) }
            } else {
                Button("Try Again", role: .close) {}
            }
        }
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
        
        if userAnswer == lesson.answer {
            wasCorrect = true
            resultMessage = "Correct!"
        } else {
            resultMessage = "Incorrect."
        }
        isShowingResult = true
    }
}
