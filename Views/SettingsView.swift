import SwiftUI

struct SettingsView: View {
    @Bindable var settings: AppSettings
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Appearance") {
                    Picker("Accent Colour", selection: $settings.accentColorRawValue) {
                        ForEach(AccentColorOption.allCases) { option in
                            HStack {
                                Circle()
                                    .fill(option.color)
                                    .frame(width: 14, height: 14)
                                Text(option.title)
                            }
                            .tag(option.rawValue)
                        }
                    }
                }
                
                Section("Progress") {
                    Toggle("Unlock all lessons", isOn: $settings.unlockAllLessons)
                }
                
                Section("Answers") {
                    Picker("Default method", selection: $settings.defaultAnswerModeRawValue) {
                        ForEach(AnswerMode.allCases) { mode in
                            Text(mode.title).tag(mode.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
