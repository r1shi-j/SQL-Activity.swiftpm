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
            title: "L0 Introduction", subtitle: "What is SQL?",
            slides: [
                Slide(kind: .info(Info(
                    title: "What is a database?",
                    sections: [
                        InfoSection(
                            title: "Think of a spreadsheet",
                            body: "A database stores information in tables. Tables have rows (records) and columns (fields)."
                        ),
                        InfoSection(
                            title: "Tables you can ask questions about",
                            body: "SQL is the language you use to ask questions like ‘Which pets are older than 3?’"
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "Meet our example data",
                    sections: [
                        InfoSection(
                            title: "Animals table",
                            body: "Animals(id, name, species, age)\n\n1 | Luna | cat | 2\n2 | Max | dog | 5\n3 | Kiwi | bird | 1\n4 | Nova | cat | 4"
                        ),
                        InfoSection(
                            title: "Owners table",
                            body: "Owners(id, name, city)\n\n1 | Alex | London\n2 | Priya | Tokyo\n3 | Sam | Toronto"
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "What is SQL?",
                    sections: [
                        InfoSection(
                            title: "A question language",
                            body: "SQL (Structured Query Language) lets you read and change data stored in tables."
                        ),
                        InfoSection(
                            title: "Start with SELECT",
                            body: "Most queries start with SELECT and tell the database what columns and table to read from."
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "The basic pattern",
                    sections: [
                        InfoSection(
                            title: "SELECT → FROM → WHERE → ORDER BY",
                            body: "SELECT chooses columns. FROM picks the table. WHERE filters rows. ORDER BY sorts the result."
                        ),
                        InfoSection(
                            title: "Example",
                            body: "SELECT name, age FROM Animals WHERE age > 3 ORDER BY age DESC"
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "How to read results",
                    sections: [
                        InfoSection(
                            title: "A result is a new table",
                            body: "Every SQL query returns a table. Sometimes it has fewer rows (filtered), sometimes fewer columns (selected)."
                        ),
                        InfoSection(
                            title: "You’re ready",
                            body: "Next, you’ll build your first SELECT queries using blocks."
                        )
                    ]
                )))
            ]
        ),
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
                    tip: "Tip: Tap a block to add/remove. Long-press the grip to reorder.",
                    hint: "Remember: SELECT * FROM table.",
                    schema: "Animals(id, name, species, age)",
                    answer: "SELECT * FROM Animals",
                    blocks: ["SELECT", "FROM", "*", "Animals", "Pets", "WHERE", "age", ">", "2"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select name and species from Animals.",
                    tip: "Tip: Use a comma between columns.",
                    hint: "List columns before FROM.",
                    schema: "Animals(id, name, species, age)",
                    answer: "SELECT name, species FROM Animals",
                    blocks: ["SELECT", "FROM", "name", "species", "age", "Animals", "Owners", ",", ","]
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
                    tip: "Tip: Tap a block to add/remove. Long-press the grip to reorder.",
                    hint: "Use WHERE age > 3.",
                    schema: "Dogs(id, name, age, breed)",
                    answer: "SELECT * FROM Dogs WHERE age > 3",
                    blocks: ["SELECT", "FROM", "WHERE", "*", "Dogs", "Cats", "age", "3", "2", ">", "<", "="]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select name and age for dogs older than 3 and order by age desc.",
                    tip: "Tip: ORDER BY comes after WHERE.",
                    hint: "DESC is descending.",
                    schema: "Dogs(id, name, age, breed)",
                    answer: "SELECT name, age FROM Dogs WHERE age > 3 ORDER BY age DESC",
                    blocks: ["SELECT", "FROM", "WHERE", "ORDER BY", "name", "age", "age", "Dogs", "Animals", ">", "3", "DESC", "ASC", ","]
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
                    schema: "Owners(id, name, city)\nPets(id, name, owner_id)",
                    answer: "SELECT Owners.name, Pets.name FROM Owners INNER JOIN Pets ON Owners.id = Pets.owner_id",
                    blocks: ["SELECT", "FROM", "INNER JOIN", "LEFT JOIN", "ON", "Owners", "Pets", "Owners.name", "Pets.name", "Owners.id", "Pets.owner_id", ",", ","]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show pet name and owner city using a join.",
                    tip: "Tip: Choose columns from each table.",
                    hint: "Pets.owner_id links to Owners.id.",
                    schema: "Owners(id, name, city)\nPets(id, name, owner_id)",
                    answer: "SELECT Pets.name, Owners.city FROM Pets INNER JOIN Owners ON Pets.owner_id = Owners.id",
                    blocks: ["SELECT", "FROM", "INNER JOIN", "ON", "Owners", "Pets", "Pets.name", "Owners.city", "Owners.name", "Pets.owner_id", "Owners.id", ",", ","]
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
                    schema: "Animals(id, name, species, age)",
                    answer: "SELECT species, COUNT ( * ) FROM Animals GROUP BY species",
                    blocks: ["SELECT", "FROM", "GROUP BY", "COUNT", "(", ")", "*", "species", "species", "Animals", "HAVING", ">", "2", ",", ","]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show species with more than 2 animals.",
                    tip: "Tip: HAVING filters groups after GROUP BY.",
                    hint: "Use HAVING COUNT ( * ) > 2.",
                    schema: "Animals(id, name, species, age)",
                    answer: "SELECT species, COUNT ( * ) FROM Animals GROUP BY species HAVING COUNT ( * ) > 2",
                    blocks: ["SELECT", "FROM", "GROUP BY", "HAVING", "COUNT", "COUNT", "(", "(", ")", ")", "*", "*", "species", "species", "Animals", ">", "2", ",", ","]
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
        ),
        Lesson(
            title: "L5 Insert / Update / Delete", subtitle: "Modify data",
            slides: [
                Slide(kind: .info(Info(
                    title: "Changing data",
                    sections: [
                        InfoSection(
                            title: "INSERT",
                            body: "INSERT adds new rows into a table."
                        ),
                        InfoSection(
                            title: "UPDATE + DELETE",
                            body: "UPDATE edits existing rows. DELETE removes rows that match a condition."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Insert a new animal named Milo, a cat, age 2.",
                    tip: "Tip: Columns go in the first parentheses, values in the second.",
                    hint: "Use INSERT INTO ... VALUES (...)",
                    schema: "Animals(id, name, species, age)",
                    answer: "INSERT INTO Animals ( name, species, age ) VALUES ( 'Milo', 'cat', 2 )",
                    blocks: [
                        "INSERT", "INTO", "VALUES", "Animals", "(", ")", "(", ")",
                        "name", "species", "age", ",", ",", ",", "'Milo'", "'cat'", "2"
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Update Milo’s age to 4.",
                    tip: "Tip: SET chooses which column to change.",
                    hint: "Use WHERE name = 'Milo'.",
                    schema: "Animals(id, name, species, age)",
                    answer: "UPDATE Animals SET age = 4 WHERE name = 'Milo'",
                    blocks: ["UPDATE", "SET", "WHERE", "Animals", "age", "name", "=", "=", "4", "'Milo'"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Delete animals younger than 2.",
                    tip: "Tip: DELETE works with WHERE just like SELECT.",
                    hint: "Use DELETE FROM ... WHERE age < 2",
                    schema: "Animals(id, name, species, age)",
                    answer: "DELETE FROM Animals WHERE age < 2",
                    blocks: ["DELETE", "FROM", "WHERE", "Animals", "age", "<", "2"]
                ))),
                Slide(kind: .info(Info(
                    title: "Data changed",
                    sections: [
                        InfoSection(
                            title: "Be careful",
                            body: "UPDATE and DELETE are powerful. Always check your WHERE clause."
                        ),
                        InfoSection(
                            title: "Next step",
                            body: "Let’s explore distinct values and pattern matching next."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "L6 Distinct / Like / Limit", subtitle: "Refine results",
            slides: [
                Slide(kind: .info(Info(
                    title: "Refine results",
                    sections: [
                        InfoSection(
                            title: "DISTINCT",
                            body: "DISTINCT removes duplicate rows from a result set."
                        ),
                        InfoSection(
                            title: "LIKE + LIMIT",
                            body: "LIKE matches patterns in text. LIMIT restricts how many rows you get."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List distinct species from Animals.",
                    tip: "Tip: DISTINCT goes right after SELECT.",
                    hint: "SELECT DISTINCT species FROM Animals",
                    schema: "Animals(id, name, species, age)",
                    answer: "SELECT DISTINCT species FROM Animals",
                    blocks: ["SELECT", "DISTINCT", "FROM", "species", "Animals", "name"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List the oldest 5 animals by age.",
                    tip: "Tip: ORDER BY before LIMIT.",
                    hint: "Use ORDER BY age DESC LIMIT 5",
                    schema: "Animals(id, name, species, age)",
                    answer: "SELECT name FROM Animals ORDER BY age DESC LIMIT 5",
                    blocks: ["SELECT", "FROM", "ORDER BY", "LIMIT", "name", "Animals", "age", "DESC", "ASC", "5"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Find owner names that start with A.",
                    tip: "Tip: LIKE works with wildcards like %.",
                    hint: "Use WHERE name LIKE 'A%'.",
                    schema: "Owners(id, name, city)",
                    answer: "SELECT name FROM Owners WHERE name LIKE 'A%'",
                    blocks: ["SELECT", "FROM", "WHERE", "LIKE", "name", "Owners", "'A%'", "'B%'", "city"]
                ))),
                Slide(kind: .info(Info(
                    title: "Nice refinements",
                    sections: [
                        InfoSection(
                            title: "Better questions",
                            body: "DISTINCT and LIKE help you ask more precise questions."
                        ),
                        InfoSection(
                            title: "What next",
                            body: "You now have a strong SQL foundation. Try mixing these ideas in practice mode."
                        )
                    ]
                )))
            ]
        )
    ]
}
