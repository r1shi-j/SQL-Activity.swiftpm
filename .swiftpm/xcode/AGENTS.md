# AGENTS.md

## Project overview and purpose
SQL Activity is an iPad-only SwiftUI learning app that teaches SQL fundamentals with block-based exercises and short info slides. Users complete lessons by assembling SQL queries from draggable/tappable blocks.

## Key architecture decisions
- SwiftUI-first UI with light model structs (Lesson, Slide, Activity, Info).
- Slide is the unit of progression. Each slide is either info or activity.
- ActivitySession tracks per-activity state (used blocks, correctness, completion) without persistence.
- Lesson progress lives in memory inside HomeView.

## Important conventions and patterns
- 4-space indentation and simple SwiftUI View bodies.
- Activities use exact string matching for correctness; answers must match token spacing.
- Blocks are identified by UUIDs; drag-and-drop uses the UUID string payload.
- Tips/hints are optional and live on Activity.

## Build/run instructions
- Open the SwiftPM package in Xcode.
- Choose an iPad simulator or a connected iPad device.
- Run the app from Xcode.

## Quirks / gotchas
- Answer validation is strict: the joined block tokens must exactly match the answer string.
- Adding new activities requires aligning `blocks` tokens with `answer` spacing.
- Drag-and-drop is implemented via drop destinations on the used/available areas.
