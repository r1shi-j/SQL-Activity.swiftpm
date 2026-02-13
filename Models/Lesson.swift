//
//  Lesson.swift
//  SQL Activity
//
//  Created by Rishi Jansari on 12/02/2026.
//

import Foundation

struct Lesson: Equatable, Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String?
    var slides: [Slide]
    var isComplete = false
}

extension Lesson {
    static let defaultLessons = [
        Lesson(
            title: "L1 Activity 1", subtitle: "Basic SQL Queries",
            slides: [
                Slide(kind: .activity(Activity(
                    question: "Write an SQL query to select all fields from the table Animals, for the animals older than 2 years.",
                    hint: "This is a hint",
                    answer: "SELECT",// * FROM Animals WHERE age > 2",
                    blocks: ["SELECT", "FROM", "WHERE", "*", "Name", "City", "Dogs", "Animals", "Pets", "age", "height", "2", "1.7", "3", "5", "<", ">", "="]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select the name and age for dogs older than 3 and order by age desc.",
                    hint: nil,
                    answer: "SELECT",// name , age FROM Dogs WHERE age > 3 ORDER BY age DESC",
                    blocks: ["SELECT", "FROM", "WHERE", "ORDER BY", "name", "age", "Dogs", "Animals", ">", "age", "3", "DESC", "ASC", ",", "age"]
                )))
            ]
//            activities: [
//                Activity(
//                    question: "Write an SQL query to select all fields from the table Animals, for the animals older than 2 years.",
//                    hint: "This is a hint",
//                    answer: "SELECT",// * FROM Animals WHERE age > 2",
//                    blocks: ["SELECT", "FROM", "WHERE", "*", "Name", "City", "Dogs", "Animals", "Pets", "age", "height", "2", "1.7", "3", "5", "<", ">", "="]
//                ),
//                Activity(
//                    question: "Select the name and age for dogs older than 3 and order by age desc.",
//                    hint: nil,
//                    answer: "SELECT",// name , age FROM Dogs WHERE age > 3 ORDER BY age DESC",
//                    blocks: ["SELECT", "FROM", "WHERE", "ORDER BY", "name", "age", "Dogs", "Animals", ">", "age", "3", "DESC", "ASC", ",", "age"]
//                )
//            ], infos: [
//                
//            ]
        ),
        Lesson(
            title: "L2 Activity 2", subtitle: "Filtering and Ordering",
            slides: [
                Slide(kind: .activity(Activity(
                    question: "Write an SQL query to select all fields from the table Animals, for the animals older than 2 years.",
                    hint: "This is a hint",
                    answer: "SELECT",// * FROM Animals WHERE age > 2",
                    blocks: ["SELECT", "FROM", "WHERE", "*", "Name", "City", "Dogs", "Animals", "Pets", "age", "height", "2", "1.7", "3", "5", "<", ">", "="]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select the name and age for dogs older than 3 and order by age desc.",
                    hint: nil,
                    answer: "SELECT",// name , age FROM Dogs WHERE age > 3 ORDER BY age DESC",
                    blocks: ["SELECT", "FROM", "WHERE", "ORDER BY", "name", "age", "Dogs", "Animals", ">", "age", "3", "DESC", "ASC", ",", "age"]
                )))
            ]
        )
    ]
}
