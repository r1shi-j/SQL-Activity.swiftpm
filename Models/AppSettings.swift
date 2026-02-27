import Foundation

@Observable
final class AppSettings {
    private enum Keys {
        static let accentColor = "settings.accentColor"
        static let unlockAllLessons = "settings.unlockAllLessons"
        static let defaultAnswerMode = "settings.defaultAnswerMode"
        static let hasSeenOnboarding = "settings.hasSeenOnboarding"
    }
    
    private let defaults: UserDefaults
    
    var accentColorRawValue: String {
        didSet { defaults.set(accentColorRawValue, forKey: Keys.accentColor) }
    }
    
    var unlockAllLessons: Bool {
        didSet { defaults.set(unlockAllLessons, forKey: Keys.unlockAllLessons) }
    }
    
    var defaultAnswerModeRawValue: String {
        didSet { defaults.set(defaultAnswerModeRawValue, forKey: Keys.defaultAnswerMode) }
    }
    
    var hasSeenOnboarding: Bool {
        didSet { defaults.set(hasSeenOnboarding, forKey: Keys.hasSeenOnboarding) }
    }
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.accentColorRawValue = defaults.string(forKey: Keys.accentColor) ?? AccentColorOption.indigo.rawValue
        self.unlockAllLessons = defaults.object(forKey: Keys.unlockAllLessons) as? Bool ?? false
        self.defaultAnswerModeRawValue = defaults.string(forKey: Keys.defaultAnswerMode) ?? AnswerMode.blocks.rawValue
        self.hasSeenOnboarding = defaults.object(forKey: Keys.hasSeenOnboarding) as? Bool ?? false
    }
    
    var accentColorOption: AccentColorOption {
        AccentColorOption(rawValue: accentColorRawValue) ?? .indigo
    }
    
    var defaultAnswerMode: AnswerMode {
        AnswerMode(rawValue: defaultAnswerModeRawValue) ?? .blocks
    }
}
