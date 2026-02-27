import SwiftUI

struct SettingsView: View {
    @Bindable var settings: AppSettings
    let onReplayOnboarding: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    init(settings: AppSettings, onReplayOnboarding: @escaping () -> Void = {}) {
        self._settings = Bindable(settings)
        self.onReplayOnboarding = onReplayOnboarding
    }
    
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
                
                Section("About") {
                    Button("Replay intro") {
                        dismiss()
                        onReplayOnboarding()
                    }
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
