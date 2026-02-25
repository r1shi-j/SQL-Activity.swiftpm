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
    nonisolated(unsafe) static let defaultLessons = [
        Lesson(
            title: "L1 Select Basics", subtitle: "SELECT / FROM",
            slides: [
                Slide(kind: .info(Info(
                    title: "Start with SELECT",
                    sections: [
                        InfoSection(
                            title: "The core idea",
                            body: "A SELECT query asks a database to show data. The FROM clause tells SQL which table to read from."
                        ),
                        InfoSection(
                            title: "Pick columns",
                            body: "Use * to select every column, or list specific column names separated by commas."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select all columns from Animals.",
                    tip: "Tip: Tap a block or drag it into Your Answer. Drag a block back to remove it.",
                    hint: "Remember: SELECT * FROM table.",
                    answer: "SELECT * FROM Animals",
                    blocks: ["SELECT", "FROM", "*", "Animals", "Pets", "WHERE", "age", ">", "2"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select name and species from Animals.",
                    tip: "Tip: Use a comma between columns.",
                    hint: "List columns before FROM.",
                    answer: "SELECT name , species FROM Animals",
                    blocks: ["SELECT", "FROM", "name", "species", "age", "Animals", "Owners", ","]
                ))),
                Slide(kind: .info(Info(
                    title: "Nice work",
                    sections: [
                        InfoSection(
                            title: "What you learned",
                            body: "SELECT + FROM is the backbone of SQL. Every other clause builds on these two."
                        ),
                        InfoSection(
                            title: "Up next",
                            body: "When you are ready, move on to filtering and sorting results."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "L2 Filtering and Sorting", subtitle: "WHERE / ORDER BY",
            slides: [
                Slide(kind: .info(Info(
                    title: "Filter the rows",
                    sections: [
                        InfoSection(
                            title: "WHERE",
                            body: "WHERE filters results so you only get the rows you care about."
                        ),
                        InfoSection(
                            title: "ORDER BY",
                            body: "ORDER BY sorts results. DESC means descending, ASC means ascending."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Find all dogs older than 3.",
                    tip: "Tip: Tap a block or drag it into Your Answer. Drag a block back to remove it.",
                    hint: "Use WHERE age > 3.",
                    answer: "SELECT * FROM Dogs WHERE age > 3",
                    blocks: ["SELECT", "FROM", "WHERE", "*", "Dogs", "Cats", "age", "3", "2", ">", "<", "="]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select name and age for dogs older than 3 and order by age desc.",
                    tip: "Tip: ORDER BY comes after WHERE.",
                    hint: "DESC is descending.",
                    answer: "SELECT name , age FROM Dogs WHERE age > 3 ORDER BY age DESC",
                    blocks: ["SELECT", "FROM", "WHERE", "ORDER BY", "name", "age", "Dogs", "Animals", ">", "3", "DESC", "ASC", ","]
                ))),
                Slide(kind: .info(Info(
                    title: "Sort it out",
                    sections: [
                        InfoSection(
                            title: "Chain clauses",
                            body: "You can chain WHERE and ORDER BY to filter and then sort results."
                        ),
                        InfoSection(
                            title: "Next step",
                            body: "Next up: combining data from multiple tables with JOINs."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "L3 Joins", subtitle: "Combine tables",
            slides: [
                Slide(kind: .info(Info(
                    title: "Two tables, one story",
                    sections: [
                        InfoSection(
                            title: "JOINs",
                            body: "JOINs combine rows from two tables using a shared key."
                        ),
                        InfoSection(
                            title: "INNER JOIN",
                            body: "INNER JOIN returns only rows that match in both tables."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List owner names with their pet names.",
                    tip: "Tip: The ON clause connects the keys.",
                    hint: "Owners.id matches Pets.owner_id.",
                    answer: "SELECT Owners.name , Pets.name FROM Owners INNER JOIN Pets ON Owners.id = Pets.owner_id",
                    blocks: ["SELECT", "FROM", "INNER JOIN", "LEFT JOIN", "ON", "Owners", "Pets", "Owners.name", "Pets.name", "Owners.id", "Pets.owner_id", ","]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show pet name and owner city using a join.",
                    tip: "Tip: Choose columns from each table.",
                    hint: "Pets.owner_id links to Owners.id.",
                    answer: "SELECT Pets.name , Owners.city FROM Pets INNER JOIN Owners ON Pets.owner_id = Owners.id",
                    blocks: ["SELECT", "FROM", "INNER JOIN", "ON", "Owners", "Pets", "Pets.name", "Owners.city", "Owners.name", "Pets.owner_id", "Owners.id", ","]
                ))),
                Slide(kind: .info(Info(
                    title: "Joined up",
                    sections: [
                        InfoSection(
                            title: "Why joins matter",
                            body: "JOINs are how you tell bigger stories with your data."
                        ),
                        InfoSection(
                            title: "Next step",
                            body: "Next up: aggregation with COUNT and GROUP BY."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "L4 Aggregation", subtitle: "COUNT / GROUP BY / HAVING",
            slides: [
                Slide(kind: .info(Info(
                    title: "Count and group",
                    sections: [
                        InfoSection(
                            title: "Aggregation",
                            body: "Aggregation lets you summarize data with functions like COUNT, SUM, and AVG."
                        ),
                        InfoSection(
                            title: "GROUP BY + HAVING",
                            body: "GROUP BY collects rows into groups. HAVING filters groups after they are made."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Count animals per species.",
                    tip: "Tip: COUNT goes in the SELECT list.",
                    hint: "Use GROUP BY species.",
                    answer: "SELECT species , COUNT ( * ) FROM Animals GROUP BY species",
                    blocks: ["SELECT", "FROM", "GROUP BY", "COUNT", "(", ")", "*", "species", "Animals", "HAVING", ">", "2", ","]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show species with more than 2 animals.",
                    tip: "Tip: HAVING filters groups after GROUP BY.",
                    hint: "Use HAVING COUNT ( * ) > 2.",
                    answer: "SELECT species , COUNT ( * ) FROM Animals GROUP BY species HAVING COUNT ( * ) > 2",
                    blocks: ["SELECT", "FROM", "GROUP BY", "HAVING", "COUNT", "(", ")", "*", "species", "Animals", ">", "2", ","]
                ))),
                Slide(kind: .info(Info(
                    title: "You are aggregating now",
                    sections: [
                        InfoSection(
                            title: "What you learned",
                            body: "COUNT and GROUP BY turn raw rows into useful summaries."
                        ),
                        InfoSection(
                            title: "What’s next",
                            body: "From here you can learn INSERT, UPDATE, and DELETE to change data."
                        )
                    ]
                )))
            ]
        )
    ]
}
