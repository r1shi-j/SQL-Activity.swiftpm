import SwiftUI
import Flow

struct Block: Equatable, Hashable, Identifiable {
    let id = UUID()
    let content: String
    var isUsed = false
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ActivityView(
                    question: "Write an SQL query to select all fields from the table Animals, for the animals older than 2 years.",
                    answer: "SELECT * FROM Animals WHERE age > 2",
                    onCorrectAnswer: {
                        print("done")
                    },
                    blocks: ["SELECT", "FROM", "WHERE", "*", "Name", "City", "Dogs", "Animals", "Pets", "age", "height", "2", "1.7", "3", "5", "<", ">", "="],
                )
            }
            .navigationTitle("Activity 1")
            .navigationBarTitleDisplayMode(.inline)
            .navigationSubtitle("Basic SQL Queries")
        }
    }
}

struct ActivityView: View {
    let question: String
    let answer: String
    let onCorrectAnswer: () -> ()
    
    let initialBlocks: [Block]
    @State private var allBlocks: [Block]
    @State private var usedBlocks: [Block] = []
    
    init(question: String, answer: String, onCorrectAnswer: @escaping () -> Void, blocks: [String]) {
        self.question = question
        self.answer = answer
        self.onCorrectAnswer = onCorrectAnswer
        
        let newBlocks = blocks.map {
            Block(content: $0)
        }
        initialBlocks = newBlocks
        _allBlocks = State(initialValue: newBlocks)
    }
    
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    @State private var wasCorrect = false
    
    var body: some View {
        VStack {
            Text(question)
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
        .toolbar {
            ToolbarItem(placement: .destructiveAction) {
                Button("Clear", systemImage: "arrow.trianglehead.counterclockwise", action: clearUserAnswer)
                    .tint(.red)
            }
            ToolbarItem(placement: .bottomBar) {
                Button("Submit", role: .confirm, action: verifyAnswer)
                    .font(.title)
                    .padding(8)
                    .buttonStyle(.glassProminent)
                    .tint(.blue)
            }
        }
        
        .alert(alertMessage, isPresented: $isShowingAlert) {
            if wasCorrect {
                // Title needs to be dynamic based on whether end of kesson
                Button("Next Activity", role: .confirm) { onCorrectAnswer() }
            } else {
                Button("Try Again", role: .close) {}
            }
        }
    }
    
    private func drawBlock(title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(title, action: action)
            .buttonStyle(GlassBlockButtonStyle(color: color))
    }
    
    private func verifyAnswer() {
        let userAnswer = usedBlocks.map(\.content).joined(separator: " ")
        
        if userAnswer == answer {
            wasCorrect = true
            alertMessage = "Correct!"
        } else {
            alertMessage = "Incorrect."
        }
        isShowingAlert = true
    }
    
    private func clearUserAnswer() {
        guard allBlocks != initialBlocks else { return }
        withAnimation {
            allBlocks = initialBlocks
            usedBlocks = []
        }
    }
}

struct GlassBlockButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .padding()
            .foregroundStyle(.black)
            .frame(minWidth: 100)
            .glassEffect(.regular.interactive().tint(color))
    }
}
