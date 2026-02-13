import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

/* Make info slides with demos:
 Confirmation on back button: Like duolingo, if exiting lesson show confirmation that data isn't saved
 Add back and next navigation which save the states of past slides and keeps them disabled
 Maybe show summary of what have learn as last slide
*/

/*
 TODO: list below
 Make info slides with demos
 Each lesson has multiple slides, some demos and then some exercises
 For basic app, include a lesson on each sql 'topic'
 
 Add ask apple intelligence for help
 
 Use matched gemoetry effect for better transitions
 Add grab and place block instead of clicking to add, drag to reorder
 Make custom lesson list layout
 Show hints after a failed attempt
 Mark lessons as failed
 Splash screen
 Use new ios/swiftui features
 Make app icon
 Make settings view
 Add SwiftData
*/
