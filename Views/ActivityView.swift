//
//  ActivityView.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import Flow
import SwiftUI

struct ActivityView: View {
    private enum AnswerMode: String, CaseIterable {
        case blocks = "Blocks"
        case text = "Text"
    }
    
    let activity: Activity
    var session: ActivitySession
    let isLast: Bool
    let onCompletion: () -> Void
    
    @State private var availableBlocks: [Block]
    @State private var usedBlocks: [Block] = []
    @State private var isShowingHint = false
    @State private var answerMode: AnswerMode = .blocks
    @State private var textAnswer = ""
    @State private var draggingBlockId: UUID? = nil
    @State private var blockFrames: [UUID: CGRect] = [:]
    @State private var insertionLine: InsertionLine? = nil
    
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
            
            if let schema = activity.schema {
                GroupBox("Schema") {
                    Text(schema)
                        .font(.system(.subheadline, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 4)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            HStack {
                Text("Your Answer")
                    .font(.headline)
                Spacer()
                answerModePicker
                Spacer()
            }
            .padding()
            
            if answerMode == .blocks {
                blocksAnswerSection
            } else {
                textAnswerSection
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
            }
        }
        .alert(activity.hint ?? "", isPresented: $isShowingHint) {}
        .onChange(of: answerMode) { oldValue, newValue in
            if newValue == .text {
                textAnswer = usedBlocks.map(\.content).joined(separator: " ")
            }
        }
    }
    
    private var answerModePicker: some View {
        Picker("Answer Mode", selection: $answerMode) {
            ForEach(AnswerMode.allCases, id: \.self) { mode in
                Text(mode.rawValue).tag(mode)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 320)
    }
    
    private var blocksAnswerSection: some View {
        VStack {
            usedBlocksFlow
                .padding(.horizontal)
            
            if !session.hasBeenCompleted {
                Divider().padding(.vertical)
                
                Text("Available Blocks")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                    ForEach(availableBlocks, id: \.id) { block in
                        blockButton(block, color: .red.opacity(0.4)) {
                            addBlock(block)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                
                Divider().padding(.vertical)
            }
        }
    }
    
    private var usedBlocksFlow: some View {
        HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
            ForEach(usedBlocks, id: \.id) { block in
                usedBlockView(block)
                    .background(blockFrameReader(for: block.id))
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .coordinateSpace(name: "UsedBlocks")
        .overlay {
            if let insertionLine {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 3, height: insertionLine.height)
                    .position(x: insertionLine.x, y: insertionLine.y)
                    .animation(.easeInOut(duration: 0.12), value: insertionLine)
            }
        }
        .onPreferenceChange(BlockFramePreferenceKey.self) { blockFrames = $0 }
    }
    
    private func usedBlockView(_ block: Block) -> some View {
        HStack(spacing: 6) {
            blockButton(block, color: .green.opacity(0.4)) {
                removeBlock(block)
            }
            
            Image(systemName: "line.3.horizontal")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.trailing, 8)
                .contentShape(.rect)
                .gesture(reorderGesture(for: block))
                .accessibilityLabel("Reorder")
        }
        .opacity(draggingBlockId == block.id ? 0.6 : 1)
        .animation(.easeInOut(duration: 0.12), value: draggingBlockId)
    }
    
    private var textAnswerSection: some View {
        TextEditor(text: $textAnswer)
            .font(.system(.body, design: .monospaced))
            .frame(minHeight: 160)
            .padding(8)
            .background(.white.opacity(0.8))
            .clipShape(.rect(cornerRadius: 12))
            .padding(.horizontal)
    }
    
    private func blockButton(_ block: Block, color: Color, action: @escaping () -> Void) -> some View {
        Button(block.content, action: action)
            .buttonStyle(GlassBlockButtonStyle(color: color))
            .contentShape(.capsule)
            .frame(height: 70)
            .onTapGesture(perform: action)
    }
    
    private func reorderGesture(for block: Block) -> some Gesture {
        LongPressGesture(minimumDuration: 0.2)
            .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .named("UsedBlocks")))
            .onChanged { value in
                switch value {
                    case .first(true):
                        draggingBlockId = block.id
                        updateInsertionLine(for: block.id, location: blockCenter(for: block.id))
                    case .second(true, let drag?):
                        draggingBlockId = block.id
                        updateInsertionLine(for: block.id, location: drag.location)
                    default:
                        break
                }
            }
            .onEnded { value in
                defer {
                    draggingBlockId = nil
                    insertionLine = nil
                }
                switch value {
                    case .second(true, let drag?):
                        finalizeReorder(draggedId: block.id, location: drag.location)
                    default:
                        break
                }
            }
    }
    
    private func blockFrameReader(for id: UUID) -> some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: BlockFramePreferenceKey.self, value: [id: proxy.frame(in: .named("UsedBlocks"))])
        }
    }
    
    private func blockCenter(for id: UUID) -> CGPoint {
        guard let frame = blockFrames[id] else { return .zero }
        return CGPoint(x: frame.midX, y: frame.midY)
    }
    
    private func updateInsertionLine(for draggedId: UUID, location: CGPoint) {
        guard let insertion = insertionInfo(for: draggedId, location: location) else {
            insertionLine = nil
            return
        }
        insertionLine = insertion
    }
    
    private func finalizeReorder(draggedId: UUID, location: CGPoint) {
        guard let info = insertionInfo(for: draggedId, location: location),
              let fromIndex = usedBlocks.firstIndex(where: { $0.id == draggedId }) else { return }
        
        var targetIndex = info.index
        if targetIndex > fromIndex { targetIndex -= 1 }
        guard targetIndex != fromIndex else { return }
        
        withAnimation {
            let block = usedBlocks.remove(at: fromIndex)
            usedBlocks.insert(block, at: targetIndex)
            syncSessionUsedIndices()
        }
    }
    
    private func insertionInfo(for draggedId: UUID, location: CGPoint) -> InsertionLine? {
        let frames = usedBlocks.compactMap { blockFrames[$0.id] }
        guard !frames.isEmpty else { return nil }
        
        var nearestIndex = 0
        var nearestDistance = CGFloat.greatestFiniteMagnitude
        for (index, frame) in frames.enumerated() {
            let center = CGPoint(x: frame.midX, y: frame.midY)
            let distance = hypot(center.x - location.x, center.y - location.y)
            if distance < nearestDistance {
                nearestDistance = distance
                nearestIndex = index
            }
        }
        
        let targetFrame = frames[nearestIndex]
        let insertBefore = location.x < targetFrame.midX
        let lineX = insertBefore ? targetFrame.minX : targetFrame.maxX
        let insertIndex = insertBefore ? nearestIndex : nearestIndex + 1
        let line = InsertionLine(x: lineX, y: targetFrame.midY, height: targetFrame.height, index: insertIndex)
        return line
    }
    
    private func addBlock(_ block: Block) {
        moveBlockToUsed(id: block.id)
    }
    
    private func removeBlock(_ block: Block) {
        moveBlockToAvailable(id: block.id)
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
        let candidate = answerMode == .text
            ? textAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
            : usedBlocks.map(\.content).joined(separator: " ")
        
        withAnimation {
            session.wasCorrect = candidate == activity.answer
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
    
    private func syncSessionUsedIndices() {
        session.usedIndices = usedBlocks.compactMap { block in
            activity.initialBlocks.firstIndex(where: { $0.id == block.id })
        }
    }
}
private struct InsertionLine: Equatable {
    let x: CGFloat
    let y: CGFloat
    let height: CGFloat
    let index: Int
}

private struct BlockFramePreferenceKey: PreferenceKey {
    static var defaultValue: [UUID: CGRect] { [:] }
    
    static func reduce(value: inout [UUID: CGRect], nextValue: () -> [UUID: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

