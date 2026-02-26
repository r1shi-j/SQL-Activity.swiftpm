# Journal.md

## The Big Picture
Imagine a workbook for SQL, but the pages are interactive and the answers snap together like LEGO. That is this app. It is a focused iPad experience where students learn SQL by dragging and tapping query blocks into place, step by step.

## Architecture Deep Dive
Think of the app like a restaurant:
- The **menu wall** is the HomeView lesson map, showing what is done, what is current, and what is still locked.
- Each **course** is a Lesson, made of slides.
- A **slide** is either the waiter explaining something (Info) or the kitchen asking you to assemble a dish (Activity).
- The **kitchen ticket** is ActivitySession, keeping track of what blocks you used and whether the order is correct.

## The Codebase Map
- `MyApp.swift`: App entry point.
- `Views/`: UI screens (Home, Lesson, Info, Activity).
- `Models/`: Lesson/Slide/Activity/Info/Block and session state.
- `Helpers/`: button styles and UI polish.
- `Views/LessonMap/`: lesson-map feature views split by responsibility (map shell, node row, card, indicator, divider).
- `Views/Lesson/`: lesson-specific supporting UI such as completion-sheet content.

## Tech Stack & Why
- **SwiftUI**: fast iteration, great for rich, animated iPad layouts.
- **SwiftPM**: keeps the project lean and easy to share for the student challenge.
- **Flow**: simple layout for block clusters so the UI can “wrap” blocks naturally.

## The Journey
- Added drag-and-drop so blocks can be moved between “Available” and “Your Answer.” It makes the app feel more tactile on iPad and reduces friction vs. tap-only.
- Added activity tips so users know the interaction model immediately.
- Expanded the data set with lessons for SELECT, WHERE/ORDER BY, JOINs, and aggregation.
- Refactored Info content into flexible sections so each slide can have meaningful headings (no more empty subheadings).
- Added in-place reordering for used blocks and tightened move logic to avoid occasional add/remove misses.
- Gotcha: answer validation is strict string matching. Every block token and space matters, so answers must mirror the block list exactly.
- Replaced the old HomeView lesson list with the new map UI prototype and connected it to real `Lesson` data. War story: the prototype looked done but was fully fake, so the real work was wiring status logic (`completed/current/locked`) and preserving existing `LessonView` navigation callbacks.
- Portrait-mode cleanup: the lesson cards were drifting into the center divider because spacer math was too loose. Fix was to treat each row like two strict half-columns with a fixed center node, then use weighted spacing (`4:1`) inside the active half so cards keep a consistent gap from the divider.
- Added a real Settings sheet from Home (gear icon) with three controls: accent color, unlock-all-lessons toggle, and default answer method. Gotcha: default answer mode had to be threaded through `HomeView -> LessonView -> ActivityView` so it affects new activity attempts without breaking completed session restores.
- Refactored a large `LessonMapView.swift` into a feature folder with small focused files. Bonus cleanup: moved lesson completion sheet UI out of `LessonView` so logic and presentation are easier to scan independently.
- Accent-color polish pass: removed global app tint so system controls (alerts and navigation/back actions) keep native styling, and forced the “Ask for help” label to `.primary` for readability on high-contrast accent choices like teal.
- Tint-scoping refinement: using a global `.tint(...)` was too blunt because it recolored alert actions and top nav back controls. Better pattern is targeted tint: apply accent only to the controls that should feel branded (settings button/sheet, in-lesson slide back, ask-for-help) and explicitly keep nav-alert actions at system default.

## Engineer's Wisdom
- Small models + clear view composition beats giant view controllers.
- Keep interactions reversible; dragging a block back out should be as easy as adding it.
- Teach with a rhythm: explain, try, reflect. The slide system makes that cadence explicit.

## If I Were Starting Over...
I would plan for persistence earlier (SwiftData), so progress survives app restarts. I would also build a richer validation layer that understands SQL meaning rather than exact string matching.
