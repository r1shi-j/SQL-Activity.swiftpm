import SwiftUI

@main
struct MyApp: App {
    @State private var settings = AppSettings()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(settings)
        }
    }
}

/*
 add better lessons, info more detailed, check for mistakes
 rename lessons
 
 Better/more animations
 Use matched gemoetry effect for better transitions
 Use custom fonts
 
 Splash screen
 Make app icon
 Use new ios/swiftui features
*/
