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

/* TODO: below
 Better/more animations
 Use matched gemoetry effect for better transitions
 Use new ios/swiftui features
 
 Redo lessons, info slides more detailed, check for mistakes, rename lessons
 Redo splash screen data
*/
