//
//  ActivityView.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import Flow
import FoundationModels
import SwiftUI

struct ActivityView: View {
    @Environment(AppSettings.self) private var settings
    
    @available(iOS 26.0, *)
    private var model: SystemLanguageModel { SystemLanguageModel.default }
    
    let activity: Activity
    var session: ActivitySession
    let isLast: Bool
    let onCompletion: () -> Void
    
    @State private var availableBlocks: [Block]
    @State private var usedBlocks: [Block] = []
    @State private var isShowingHint = false
    @State private var answerMode: AnswerMode
    @State private var textAnswer: String
    @State private var draggingBlockId: UUID? = nil
    @State private var draggingSourceSection: BlockSection? = nil
    @State private var blockFrames: [UUID: CGRect] = [:]
    @State private var containerFrames: [BlockSection: CGRect] = [:]
    @State private var insertionLine: InsertionLine? = nil
    @State private var isShowingHelp = false
    @State private var submitFeedbackTrigger = 0
    @State private var helpPrompt = ""
    @State private var helpResponse = ""
    @State private var helpError: String? = nil
    @State private var isHelpLoading = false
    
    init(activity: Activity, session: ActivitySession, isLast: Bool, onCompletion: @escaping () -> Void) {
        self.activity = activity
        self.session = session
        self.isLast = isLast
        self.onCompletion = onCompletion
        
        let used = session.usedIndices.map { activity.initialBlocks[$0] }
        self._usedBlocks = State(initialValue: used)
        
        let available = activity.initialBlocks.enumerated().filter({ !Set(session.usedIndices).contains($0.offset) }).map({ $0.element })
        self._availableBlocks = State(initialValue: available)
        
        let initialMode = AnswerMode(rawValue: session.completedMode ?? "") ?? .blocks
        self._answerMode = State(initialValue: initialMode)
        self._textAnswer = State(initialValue: session.completedAnswer ?? "")
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
                GroupBox {
                    Text(schema)
                        .font(.system(.subheadline, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 4)
                } label: {
                    Text("Schema")
                        .fontWidth(.expanded)
                }
                .padding(.horizontal)
            }
            
            HStack {
                Spacer()
                if #available(iOS 26.0, *) {
                    Button(action: openHelp) {
                        Label("Ask for help", systemImage: "sparkles")
                            .padding(4)
                    }
                    .font(.headline)
                    .fontWidth(.expanded)
                    .foregroundStyle(.primary.opacity(0.8))
                    .buttonStyle(.glassProminent)
                    .tint(settings.accentColorOption.color.opacity(0.8))
                } else {
                    Button(action: openHelp) {
                        Label("Ask for help", systemImage: "sparkles")
                            .padding(4)
                    }
                    .font(.headline)
                    .fontWidth(.expanded)
                    .foregroundStyle(.primary.opacity(0.8))
                    .buttonStyle(.borderedProminent)
                    .tint(settings.accentColorOption.color.opacity(0.8))
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Text("Your Answer")
                    .font(.headline)
                    .fontWidth(.expanded)
                Spacer()
            }
            .overlay {
                answerModePicker
            }
            .padding()
            
            if answerMode == .blocks {
                blocksAnswerSection
            } else {
                textAnswerSection
            }
            
            Spacer()
        }
        .disabled(session.wasCorrect != nil || session.hasBeenCompleted)
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
                            .tint(AppTheme.hintTint)
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
                    animatedSubmitButton(
                        title: title,
                        action: action,
                        color: color,
                        useGlassStyle: true
                    )
                } else {
                    animatedSubmitButton(
                        title: title,
                        action: action,
                        color: color,
                        useGlassStyle: false
                    )
                }
            }
        }
        .sheet(isPresented: $isShowingHelp) {
            helpSheet
                .tint(settings.accentColorOption.color)
        }
        .alert(activity.hint ?? "", isPresented: $isShowingHint) {}
        .onAppear {
            if session.completedMode == nil {
                answerMode = settings.defaultAnswerMode
            }
        }
        .onChange(of: answerMode) { oldValue, newValue in
            if newValue == .text {
                textAnswer = usedBlocks.map(\.content).joined(separator: " ")
            }
        }
        .onChange(of: session.wasCorrect) { _, newValue in
            guard newValue != nil else { return }
            submitFeedbackTrigger += 1
        }
    }
    
    private var answerModePicker: some View {
        Picker("Answer Mode", selection: $answerMode) {
            ForEach(AnswerMode.allCases, id: \.self) { mode in
                Text(mode.title).tag(mode)
            }
        }
        .pickerStyle(.segmented)
        .frame(width: 320)
    }
    
    private var helpSheet: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                if #available(iOS 26.0, *) {
                    helpAvailabilityView
                } else {
                    Text("Apple Intelligence requires iOS 26 or later.")
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("Ask for help")
                        .padding(.top)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontWidth(.expanded)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close") {
                        isShowingHelp = false
                    }
                    .fontWidth(.expanded)
                }
            }
        }
    }
    
    @available(iOS 26.0, *)
    @ViewBuilder
    private var helpAvailabilityView: some View {
        switch model.availability {
            case .available:
                VStack(alignment: .leading, spacing: 12) {
                    Text("Prompt")
                        .font(.headline)
                        .fontWidth(.expanded)
                    TextEditor(text: $helpPrompt)
                        .font(.system(.body, design: .monospaced))
                        .frame(minHeight: 140)
                        .padding(8)
                        .background(.white.opacity(0.8))
                        .clipShape(.rect(cornerRadius: 12))
                    
                    Button {
                        Task { await requestHelp() }
                    } label: {
                        Label(isHelpLoading ? "Asking…" : "Ask", systemImage: "sparkles")
                            .padding(4)
                    }
                    .font(.headline)
                    .fontWidth(.expanded)
                    .buttonStyle(.borderedProminent)
                    .disabled(isHelpLoading || helpPrompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .onAppear {
                        helpPrompt = defaultHelpPrompt()
                    }
                    
                    if isHelpLoading {
                        ProgressView()
                    }
                    
                    if let helpError {
                        Text(helpError)
                            .foregroundStyle(.red)
                    }
                    
                    if !helpResponse.isEmpty {
                        Text("Response")
                            .font(.headline)
                        ScrollView {
                            Text(helpResponse)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(minHeight: 160)
                    }
                }
            case .unavailable(.deviceNotEligible):
                Text("This device doesn’t support Apple Intelligence.")
                    .foregroundStyle(.secondary)
            case .unavailable(.appleIntelligenceNotEnabled):
                Text("Turn on Apple Intelligence in Settings to use help.")
                    .foregroundStyle(.secondary)
            case .unavailable(.modelNotReady):
                Text("The on-device model is still downloading. Try again soon.")
                    .foregroundStyle(.secondary)
            case .unavailable:
                Text("Apple Intelligence is unavailable right now.")
                    .foregroundStyle(.secondary)
        }
    }
    
    private var blocksAnswerSection: some View {
        VStack {
            usedBlocksFlow
                .padding(.horizontal)
                .background(containerFrameReader(for: .used))
            
            if !session.hasBeenCompleted {
                Divider().padding(.vertical)
                
                Text("Available Blocks")
                    .font(.headline)
                    .fontWidth(.expanded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Group {
                    if availableBlocks.isEmpty {
                        VStack(spacing: 10) {
                            Text("You have used all the available blocks.")
                                .font(.headline)
                            Text("Click a block to remove it from your answer.")
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                    } else {
                        HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                            ForEach(availableBlocks, id: \.id) { block in
                                blockButton(block, color: AppTheme.availableBlockTint) {
                                    addBlock(block)
                                }
                                .simultaneousGesture(reorderGesture(for: block))
                                .background(blockFrameReader(for: block.id))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 70)
                .padding(.horizontal)
                .background(containerFrameReader(for: .available))
                
                Divider().padding(.vertical)
            }
        }
        .coordinateSpace(name: "BlocksArea")
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
        .onPreferenceChange(BlockContainerFramePreferenceKey.self) { containerFrames = $0 }
    }
    
    private var usedBlocksFlow: some View {
        Group {
            if usedBlocks.isEmpty {
                VStack(spacing: 10) {
                    Text("You haven't used any blocks yet.")
                        .font(.headline)
                    Text("Drag a block here from below, or alternatively click a block to add it to your answer.")
                        .foregroundStyle(.secondary)
                }
                .padding()
            } else {
                HFlow(horizontalAlignment: .center, verticalAlignment: .center, horizontalSpacing: 20, verticalSpacing: 15) {
                    ForEach(usedBlocks, id: \.id) { block in
                        usedBlockView(block)
                            .background(blockFrameReader(for: block.id))
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 70)
                .contentShape(.rect)
            }
        }
    }
    
    private func usedBlockView(_ block: Block) -> some View {
        blockButton(block, color: AppTheme.usedBlockTint) {
            removeBlock(block)
        }
        .simultaneousGesture(reorderGesture(for: block))
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
    
    private func openHelp() {
        helpError = nil
        helpResponse = ""
        isHelpLoading = false
        isShowingHelp = true
    }
    
    private func defaultHelpPrompt() -> String {
        var prompt = "You are a SQL tutor. Give hints only; do not provide the full final query.\n"
        prompt += "Question: \(activity.question)\n"
        if let schema = activity.schema {
            prompt += "Schema:\n\(schema)\n"
        }
        let currentAnswer = answerMode == .text
        ? textAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        : usedBlocks.map(\.content).joined(separator: " ")
        if !currentAnswer.isEmpty {
            prompt += "My current attempt: \(currentAnswer)\n"
        }
        prompt += "Explain the next steps and common pitfalls."
        return prompt
    }
    
    @available(iOS 26.0, *)
    @MainActor
    private func requestHelp() async {
        guard model.availability == .available else {
            helpError = "Apple Intelligence is unavailable on this device right now."
            return
        }
        guard !isHelpLoading else { return }
        
        isHelpLoading = true
        helpError = nil
        helpResponse = ""
        
        let instructions = "You are a friendly SQL tutor. Provide hints and reasoning, but do not give the full final query."
        let session = LanguageModelSession(model: model, instructions: instructions)
        do {
            let response = try await session.respond(to: helpPrompt)
            helpResponse = response.content
        } catch {
            helpError = error.localizedDescription
        }
        isHelpLoading = false
    }
    
    private func animatedSubmitButton(title: String, action: @escaping () -> Void, color: Color, useGlassStyle: Bool) -> some View {
        submitActionButton(title: title, action: action, color: color, useGlassStyle: useGlassStyle)
            .phaseAnimator([0, 1, 2], trigger: submitFeedbackTrigger) { content, phase in
                let isCorrect = session.wasCorrect == true
                content
                    .scaleEffect(isCorrect ? (phase == 1 ? 1.08 : 1.0) : 1.0)
                    .offset(x: isCorrect ? 0 : (phase == 1 ? -8 : (phase == 2 ? 8 : 0)))
            } animation: { phase in
                switch phase {
                    case 0:
                            .smooth(duration: 0.08)
                    case 1:
                            .spring(duration: 0.16, bounce: 0.55)
                    case 2:
                            .spring(duration: 0.18, bounce: 0.32)
                    default:
                            .default
                }
            }
    }
    
    @ViewBuilder
    private func submitActionButton(title: String, action: @escaping () -> Void, color: Color, useGlassStyle: Bool) -> some View {
        if useGlassStyle, #available(iOS 26.0, *) {
            Button(title, action: action)
                .font(.title)
                .fontWidth(.expanded)
                .fontWeight(.regular)
                .padding(8)
                .buttonStyle(.glassProminent)
                .tint(color)
                .keyboardShortcut(.return, modifiers: [])
        } else {
            Button(title, action: action)
                .font(.title)
                .fontWidth(.expanded)
                .fontWeight(.regular)
                .padding(8)
                .background(color)
                .clipShape(.capsule)
                .padding()
                .tint(.primary)
                .keyboardShortcut(.return, modifiers: [])
        }
    }

    private func blockButton(_ block: Block, color: Color, action: @escaping () -> Void) -> some View {
        Button(block.content, action: action)
            .fontDesign(.monospaced)
            .buttonStyle(GlassBlockButtonStyle(color: color))
            .contentShape(.capsule)
            .frame(height: 70)
            .onTapGesture(perform: action)
    }

    private func canonicalSQLTokens(_ input: String) -> [String] {
        var tokens: [String] = []
        var index = input.startIndex

        while index < input.endIndex {
            let character = input[index]

            if character.isWhitespace {
                index = input.index(after: index)
                continue
            }

            if character == "'" || character == "\"" {
                let quote = character
                var token = String(quote)
                index = input.index(after: index)

                while index < input.endIndex {
                    let current = input[index]
                    token.append(current)

                    if current == quote {
                        let next = input.index(after: index)
                        if next < input.endIndex, input[next] == quote {
                            token.append(input[next])
                            index = input.index(after: next)
                            continue
                        }
                        index = next
                        break
                    }

                    index = input.index(after: index)
                }

                tokens.append(token)
                continue
            }

            if ",();*+-/%.".contains(character) {
                tokens.append(String(character))
                index = input.index(after: index)
                continue
            }

            if "<>=!".contains(character) {
                let next = input.index(after: index)
                if next < input.endIndex {
                    let pair = String(character) + String(input[next])
                    if pair == "<=" || pair == ">=" || pair == "<>" || pair == "!=" {
                        tokens.append(pair)
                        index = input.index(after: next)
                        continue
                    }
                }

                tokens.append(String(character))
                index = next
                continue
            }

            let start = index
            while index < input.endIndex {
                let current = input[index]
                if current.isWhitespace || ",();*+-/%.<>!=\"'".contains(current) {
                    break
                }
                index = input.index(after: index)
            }
            tokens.append(String(input[start..<index]))
        }

        var canonical = tokens.map { token -> String in
            if token.first == "'" || token.first == "\"" {
                return token
            }
            return token.uppercased()
        }

        while canonical.last == ";" {
            canonical.removeLast()
        }

        return canonical
    }
    
    private func formatTokens(_ tokens: [String]) -> String {
        var result = ""
        for token in tokens {
            if result.isEmpty {
                result = token
                continue
            }
            if token == "," || token == ")" || token == ";" {
                result += token
                continue
            }
            if result.last == "(" {
                result += token
                continue
            }
            result += " " + token
        }
        return result
    }
    
    private func reorderGesture(for block: Block) -> some Gesture {
        LongPressGesture(minimumDuration: 0.1)
            .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .named("BlocksArea")))
            .onChanged { value in
                switch value {
                    case .first(true):
                        draggingBlockId = block.id
                        draggingSourceSection = section(of: block.id)
                    case .second(true, let drag?):
                        draggingBlockId = block.id
                        draggingSourceSection = section(of: block.id)
                        updateInsertionLine(for: block.id, location: drag.location)
                    default:
                        break
                }
            }
            .onEnded { value in
                defer {
                    draggingBlockId = nil
                    draggingSourceSection = nil
                    insertionLine = nil
                }
                switch value {
                    case .second(true, let drag?):
                        finalizeDrag(draggedId: block.id, location: drag.location)
                    default:
                        break
                }
            }
    }
    
    private func blockFrameReader(for id: UUID) -> some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: BlockFramePreferenceKey.self, value: [id: proxy.frame(in: .named("BlocksArea"))])
        }
    }
    
    private func containerFrameReader(for section: BlockSection) -> some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: BlockContainerFramePreferenceKey.self, value: [section: proxy.frame(in: .named("BlocksArea"))])
        }
    }
    
    private func section(of id: UUID) -> BlockSection? {
        if usedBlocks.contains(where: { $0.id == id }) {
            return .used
        }
        if availableBlocks.contains(where: { $0.id == id }) {
            return .available
        }
        return nil
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
        insertionLine = insertion.line
    }
    
    private func finalizeDrag(draggedId: UUID, location: CGPoint) {
        guard let fromSection = draggingSourceSection ?? section(of: draggedId),
              let insertion = insertionInfo(for: draggedId, location: location) else { return }
        
        moveBlock(draggedId: draggedId, from: fromSection, to: insertion.section, targetIndex: insertion.index)
    }
    
    private func insertionInfo(for draggedId: UUID, location: CGPoint) -> InsertionPlacement? {
        guard let targetSection = targetSection(for: location) else { return nil }
        
        let targetBlocks = blocks(in: targetSection)
        let targetFrames = targetBlocks.compactMap { blockFrames[$0.id] }
        
        guard !targetFrames.isEmpty else {
            guard let container = containerFrames[targetSection] else { return nil }
            let line = InsertionLine(
                x: container.minX + 16,
                y: container.midY,
                height: max(40, min(70, container.height * 0.5))
            )
            return InsertionPlacement(section: targetSection, index: 0, line: line)
        }
        
        var nearestIndex = 0
        var nearestDistance = CGFloat.greatestFiniteMagnitude
        for (index, frame) in targetFrames.enumerated() {
            let center = CGPoint(x: frame.midX, y: frame.midY)
            let distance = hypot(center.x - location.x, center.y - location.y)
            if distance < nearestDistance {
                nearestDistance = distance
                nearestIndex = index
            }
        }
        
        let targetFrame = targetFrames[nearestIndex]
        let insertBefore = location.x < targetFrame.midX
        let lineX = insertBefore ? targetFrame.minX : targetFrame.maxX
        let insertIndex = insertBefore ? nearestIndex : nearestIndex + 1
        let line = InsertionLine(x: lineX, y: targetFrame.midY, height: targetFrame.height)
        return InsertionPlacement(section: targetSection, index: insertIndex, line: line)
    }
    
    private func targetSection(for location: CGPoint) -> BlockSection? {
        if let usedFrame = containerFrames[.used], usedFrame.contains(location) {
            return .used
        }
        if let availableFrame = containerFrames[.available], availableFrame.contains(location) {
            return .available
        }
        return nil
    }
    
    private func blocks(in section: BlockSection) -> [Block] {
        switch section {
            case .used:
                return usedBlocks
            case .available:
                return availableBlocks
        }
    }
    
    private func moveBlock(draggedId: UUID, from source: BlockSection, to destination: BlockSection, targetIndex: Int) {
        switch source {
            case .used:
                guard let sourceIndex = usedBlocks.firstIndex(where: { $0.id == draggedId }) else { return }
                withAnimation {
                    let block = usedBlocks.remove(at: sourceIndex)
                    if destination == .used {
                        var index = targetIndex
                        if index > sourceIndex { index -= 1 }
                        index = max(0, min(index, usedBlocks.count))
                        usedBlocks.insert(block, at: index)
                    } else {
                        let index = max(0, min(targetIndex, availableBlocks.count))
                        availableBlocks.insert(block, at: index)
                    }
                    syncSessionUsedIndices()
                }
            case .available:
                guard let sourceIndex = availableBlocks.firstIndex(where: { $0.id == draggedId }) else { return }
                withAnimation {
                    let block = availableBlocks.remove(at: sourceIndex)
                    if destination == .available {
                        var index = targetIndex
                        if index > sourceIndex { index -= 1 }
                        index = max(0, min(index, availableBlocks.count))
                        availableBlocks.insert(block, at: index)
                    } else {
                        let index = max(0, min(targetIndex, usedBlocks.count))
                        usedBlocks.insert(block, at: index)
                    }
                    syncSessionUsedIndices()
                }
        }
    }
    
    private func addBlock(_ block: Block) {
        resetDragState()
        moveBlockToUsed(id: block.id)
    }
    
    private func removeBlock(_ block: Block) {
        resetDragState()
        moveBlockToAvailable(id: block.id)
    }
    
    private func resetDragState() {
        draggingBlockId = nil
        draggingSourceSection = nil
        insertionLine = nil
    }
    
    private func showHint() {
        isShowingHint = true
    }
    
    private func clearUserAnswer() {
        guard availableBlocks != activity.initialBlocks || !usedBlocks.isEmpty || !textAnswer.isEmpty else { return }
        resetDragState()
        withAnimation {
            session.usedIndices.removeAll()
            session.completedAnswer = nil
            session.completedMode = nil
            availableBlocks = activity.initialBlocks
            usedBlocks = []
            textAnswer = ""
        }
    }
    
    private func verifyAnswer() {
        let rawCandidate: String
        if answerMode == .text {
            rawCandidate = textAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            rawCandidate = formatTokens(usedBlocks.map(\.content))
        }
        let candidateTokens = canonicalSQLTokens(rawCandidate)
        let expectedTokens = canonicalSQLTokens(activity.answer)

        withAnimation {
            let isCorrect = candidateTokens == expectedTokens
            session.wasCorrect = isCorrect
            if isCorrect {
                session.completedAnswer = rawCandidate
                session.completedMode = answerMode.rawValue
            }
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

private enum BlockSection: Hashable {
    case used
    case available
}

private struct InsertionLine: Equatable {
    let x: CGFloat
    let y: CGFloat
    let height: CGFloat
}

private struct InsertionPlacement {
    let section: BlockSection
    let index: Int
    let line: InsertionLine
}

private struct BlockFramePreferenceKey: PreferenceKey {
    static var defaultValue: [UUID: CGRect] { [:] }
    
    static func reduce(value: inout [UUID: CGRect], nextValue: () -> [UUID: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
private struct BlockContainerFramePreferenceKey: PreferenceKey {
    static var defaultValue: [BlockSection: CGRect] { [:] }
    
    static func reduce(value: inout [BlockSection: CGRect], nextValue: () -> [BlockSection: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

