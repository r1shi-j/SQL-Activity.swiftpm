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
 info slides: fix data more centrally
 
 Check data for mistakes
 Redo splash screen data
*/
