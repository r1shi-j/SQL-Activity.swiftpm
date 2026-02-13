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
                Slide(kind: .info(Info(
                    title: "My title",
                    paragraph1: "Dolor id dolor id adipisicing id occaecat excepteur qui proident dolore. Aute ex enim aliquip. Id dolor dolor dolore nostrud proident esse culpa ipsum mollit. Ex elit culpa consequat minim veniam sunt ipsum. Tempor et duis incididunt Lorem occaecat.",
                    paragraph2: "Cupidatat dolore sit dolor et non aliqua aliquip proident quis Lorem excepteur. Ipsum proident et velit in sunt proident quis quis ipsum enim. Incididunt dolor culpa officia pariatur non ut eiusmod sint voluptate nulla laborum mollit.",
                    paragraph3: "Sit occaecat nostrud laborum ut exercitation esse duis quis fugiat ad sit aute velit amet cillum. Irure ea esse aute reprehenderit aliquip. Nisi nulla ex adipisicing magna. Sit qui in occaecat id deserunt."
                ))),
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
                ))),
                Slide(kind: .info(Info(
                    title: "My conclusion title",
                    paragraph1: "Magna enim nostrud labore elit consequat consectetur minim nisi aute tempor veniam ea nostrud ipsum eu. Elit commodo magna minim cupidatat laboris Lorem excepteur non minim fugiat. Commodo occaecat qui Lorem adipisicing Lorem cillum et enim. Ut sunt amet laboris excepteur nulla do aliquip cillum cillum aute ut officia aliquip est. Quis ea ut incididunt commodo laboris nostrud magna et enim ullamco dolore qui qui non consequat. Id ut consequat dolor in aliqua. Velit dolore consectetur Lorem minim magna nulla veniam occaecat labore culpa reprehenderit. Commodo eu sit ullamco consequat in commodo ex ex.",
                    paragraph2: "Mollit ex sint magna. Aute eu nulla id esse. Cillum adipisicing excepteur voluptate qui eiusmod. Nisi pariatur sint enim do esse elit veniam laboris amet quis officia voluptate. Do nisi occaecat qui. Esse deserunt laboris sint eu irure deserunt reprehenderit mollit sint sit id dolor aliqua dolore.",
                    paragraph3: "Exercitation laboris sint veniam Lorem mollit aliqua laboris eiusmod irure aliquip. Irure cillum adipisicing culpa nostrud laboris ad laborum sit enim tempor. Incididunt minim ut magna laboris. Deserunt eu et exercitation occaecat sint duis. Eiusmod aliquip fugiat excepteur. Ex est sint excepteur elit."
                ))),
            ]
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
