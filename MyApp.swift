import SwiftUI

@main
struct MyApp: App {
    @State private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(settings)
                .preferredColorScheme(.light)
        }
    }
}
