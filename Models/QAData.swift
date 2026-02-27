//
//  QAData.swift
//  Learn SQL
//
//  Created by Rishi Jansari on 27/02/2026.
//

import Foundation

extension Lesson {
    nonisolated(unsafe) static let defaultLessons = [
        Lesson(
            title: "Welcome to SQL",
            subtitle: "How this app works",
            slides: [
                Slide(kind: .info(Info(
                    title: "Learn by building",
                    sections: [
                        InfoSection(
                            title: "Block-first learning",
                            body: "In this app, you build SQL queries from blocks. It helps you focus on query structure before memorizing syntax."
                        ),
                        InfoSection(
                            title: "Two answer modes",
                            body: "You can answer with blocks or in text mode. Blocks are ideal for learning. Text mode helps you practice writing real SQL."
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "How to complete an activity",
                    sections: [
                        InfoSection(
                            title: "Tap or drag blocks",
                            body: "Tap a block to move it between Available Blocks and Your Answer. Long-press and drag to reorder or move blocks across sections."
                        ),
                        InfoSection(
                            title: "Submit and improve",
                            body: "Submit checks your query. If it is incorrect, use Hint or AI Feedback to understand what to fix next."
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "SQL mindset",
                    sections: [
                        InfoSection(
                            title: "Ask clear questions",
                            body: "SQL is how you ask a database questions. You choose columns, tables, filters, sorting, and grouping to get exactly the data you need."
                        ),
                        InfoSection(
                            title: "Start simple",
                            body: "You will begin with SELECT and FROM, then progressively add WHERE, ORDER BY, JOIN, GROUP BY, and more."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Tables and Query Flow",
            subtitle: "Read before you write",
            slides: [
                Slide(kind: .info(Info(
                    title: "Core example schema",
                    sections: [
                        InfoSection(
                            title: "Animals",
                            body: "Animals(id, name, species, age, owner_id)"
                        ),
                        InfoSection(
                            title: "Owners",
                            body: "Owners(id, name, city)"
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "SQL clause order",
                    sections: [
                        InfoSection(
                            title: "Logical pattern",
                            body: "A common query pattern is: SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ... LIMIT ..."
                        ),
                        InfoSection(
                            title: "Build in layers",
                            body: "Write a minimal query first, run it, then add one clause at a time. This makes debugging much easier."
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "Ready for activities",
                    sections: [
                        InfoSection(
                            title: "Goal of next lessons",
                            body: "You will now practice each clause with hands-on activities. Expect distractor blocks to train careful thinking."
                        ),
                        InfoSection(
                            title: "Tip",
                            body: "If an answer looks almost right, check punctuation, clause order, and whether each needed token appears the correct number of times."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Selecting Data",
            subtitle: "SELECT and FROM",
            slides: [
                Slide(kind: .info(Info(
                    title: "Return columns from a table",
                    sections: [
                        InfoSection(
                            title: "SELECT chooses output",
                            body: "Use SELECT to choose which columns appear in the result."
                        ),
                        InfoSection(
                            title: "FROM chooses source",
                            body: "FROM tells SQL which table to read."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select every column from Animals.",
                    tip: "Build the shortest valid query.",
                    hint: "Use SELECT * FROM Animals",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT * FROM Animals"
                    ],
                    blocks: ["SELECT", "*", "FROM", "Animals", "Owners", "WHERE", "age", ">", "2"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select name and species from Animals.",
                    hint: "Use a comma between name and species.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT name, species FROM Animals"
                    ],
                    blocks: ["SELECT", "name", ",", "species", "FROM", "Animals", "Owners", "age", "*"]
                ))),
                Slide(kind: .info(Info(
                    title: "Great start",
                    sections: [
                        InfoSection(
                            title: "What you unlocked",
                            body: "You can now shape result columns and choose source tables."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Next lesson: filter rows with WHERE."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Filtering Rows",
            subtitle: "WHERE conditions",
            slides: [
                Slide(kind: .info(Info(
                    title: "Filter to relevant rows",
                    sections: [
                        InfoSection(
                            title: "WHERE applies conditions",
                            body: "WHERE keeps only rows that match your condition."
                        ),
                        InfoSection(
                            title: "Combine with AND",
                            body: "Use AND when multiple conditions must be true."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select all animals older than 2.",
                    hint: "Use WHERE age > 2.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT * FROM Animals WHERE age > 2"
                    ],
                    blocks: ["SELECT", "*", "FROM", "Animals", "WHERE", "age", ">", "2", "3", "<", "species"]
                ))),
                Slide(kind: .info(Info(
                    title: "Text conditions",
                    sections: [
                        InfoSection(
                            title: "String values",
                            body: "Text values are written in quotes, such as 'cat'."
                        ),
                        InfoSection(
                            title: "Multiple checks",
                            body: "You can combine species and age checks in one WHERE clause."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select animal names where species is 'cat' and age is at least 2.",
                    hint: "Use AND between the two conditions.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Animals WHERE species = 'cat' AND age >= 2"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Animals", "WHERE", "species", "=", "'cat'", "AND", "age", ">=", "2", "3", "OR"]
                ))),
                Slide(kind: .info(Info(
                    title: "Filter mastery",
                    sections: [
                        InfoSection(
                            title: "You can target rows",
                            body: "WHERE is one of the most-used SQL tools in real projects."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Now you will sort and trim result sets."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Sorting and Limiting",
            subtitle: "ORDER BY and LIMIT",
            slides: [
                Slide(kind: .info(Info(
                    title: "Control result order",
                    sections: [
                        InfoSection(
                            title: "ORDER BY",
                            body: "ORDER BY sorts rows. Use DESC for highest-to-lowest, ASC for lowest-to-highest."
                        ),
                        InfoSection(
                            title: "LIMIT",
                            body: "LIMIT returns only the first N rows after sorting."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Return names of the 3 oldest animals.",
                    hint: "Sort by age descending, then limit to 3.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Animals ORDER BY age DESC LIMIT 3"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Animals", "ORDER BY", "age", "DESC", "ASC", "LIMIT", "3", "5", "WHERE"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List owner names alphabetically and show only the first 5.",
                    hint: "Alphabetical order means ORDER BY name ASC.",
                    schemas: [
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Owners ORDER BY name ASC LIMIT 5",
                        "SELECT name FROM Owners ORDER BY name LIMIT 5"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Owners", "ORDER BY", "LIMIT", "ASC", "DESC", "5", "city", "WHERE"]
                ))),
                Slide(kind: .info(Info(
                    title: "Readable result sets",
                    sections: [
                        InfoSection(
                            title: "Order then limit",
                            body: "Sort first so the top N rows are meaningful."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "You will now summarize data with GROUP BY."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Grouping and Aggregation",
            subtitle: "COUNT, AVG, GROUP BY, HAVING",
            slides: [
                Slide(kind: .info(Info(
                    title: "Summarize many rows",
                    sections: [
                        InfoSection(
                            title: "Aggregate functions",
                            body: "COUNT, SUM, AVG, MIN, and MAX summarize values across rows."
                        ),
                        InfoSection(
                            title: "GROUP BY",
                            body: "GROUP BY creates one output row per group."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Count animals per species.",
                    hint: "Select species and COUNT(*), then group by species.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT species, COUNT(*) FROM Animals GROUP BY species",
                        "SELECT species, COUNT ( * ) FROM Animals GROUP BY species"
                    ],
                    blocks: ["SELECT", "species", ",", "COUNT", "(", "*", ")", "FROM", "Animals", "GROUP BY", "species", "HAVING", ">", "2"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show species where average age is greater than 3.",
                    hint: "Use HAVING after GROUP BY.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT species, AVG(age) FROM Animals GROUP BY species HAVING AVG(age) > 3",
                        "SELECT species, AVG ( age ) FROM Animals GROUP BY species HAVING AVG ( age ) > 3"
                    ],
                    blocks: ["SELECT", "species", ",", "AVG", "(", "age", ")", "FROM", "Animals", "GROUP BY", "species", "HAVING", "AVG", "(", "age", ")", ">", "3", "2"]
                ))),
                Slide(kind: .info(Info(
                    title: "You can summarize datasets",
                    sections: [
                        InfoSection(
                            title: "Why this matters",
                            body: "Aggregation helps you move from raw records to business insights."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Next you will combine tables with JOIN."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Joining Tables",
            subtitle: "INNER JOIN and ON",
            slides: [
                Slide(kind: .info(Info(
                    title: "Relational thinking",
                    sections: [
                        InfoSection(
                            title: "JOIN connects tables",
                            body: "Use JOIN when data you need lives in multiple tables."
                        ),
                        InfoSection(
                            title: "ON defines match",
                            body: "ON tells SQL how rows relate between tables, usually by IDs."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List each animal name with its owner name.",
                    hint: "Match Animals.owner_id to Owners.id.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)",
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "SELECT Animals.name, Owners.name FROM Animals INNER JOIN Owners ON Animals.owner_id = Owners.id"
                    ],
                    blocks: ["SELECT", "Animals.name", ",", "Owners.name", "FROM", "Animals", "INNER JOIN", "LEFT JOIN", "Owners", "ON", "Animals.owner_id", "=", "Owners.id", "Owners.city"]
                ))),
                Slide(kind: .info(Info(
                    title: "Adding a filter after join",
                    sections: [
                        InfoSection(
                            title: "Order of clauses",
                            body: "JOIN happens in the FROM section, then WHERE can filter joined results."
                        ),
                        InfoSection(
                            title: "Common pattern",
                            body: "SELECT columns FROM A INNER JOIN B ON ... WHERE ..."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List animal and owner names for owners in London.",
                    hint: "Use WHERE Owners.city = 'London'.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)",
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "SELECT Animals.name, Owners.name FROM Animals INNER JOIN Owners ON Animals.owner_id = Owners.id WHERE Owners.city = 'London'"
                    ],
                    blocks: ["SELECT", "Animals.name", ",", "Owners.name", "FROM", "Animals", "INNER JOIN", "Owners", "ON", "Animals.owner_id", "=", "Owners.id", "WHERE", "Owners.city", "'London'", "'Tokyo'", "AND"]
                ))),
                Slide(kind: .info(Info(
                    title: "Joined successfully",
                    sections: [
                        InfoSection(
                            title: "Cross-table queries",
                            body: "You can now answer questions that require relationships between entities."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Final lesson: modifying data safely."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Changing Data",
            subtitle: "INSERT, UPDATE, DELETE",
            slides: [
                Slide(kind: .info(Info(
                    title: "Write operations",
                    sections: [
                        InfoSection(
                            title: "INSERT",
                            body: "INSERT creates new rows."
                        ),
                        InfoSection(
                            title: "UPDATE and DELETE",
                            body: "UPDATE changes rows. DELETE removes rows. Both usually need WHERE to avoid affecting everything."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Insert a new owner named Riley in Berlin.",
                    hint: "Provide columns and then VALUES in the same order.",
                    schemas: [
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "INSERT INTO Owners (name, city) VALUES ('Riley', 'Berlin')",
                        "INSERT INTO Owners ( name, city ) VALUES ( 'Riley', 'Berlin' )"
                    ],
                    blocks: ["INSERT", "INTO", "Owners", "(", "name", ",", "city", ")", "VALUES", "(", "'Riley'", ",", "'Berlin'", ")", "UPDATE", "WHERE"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Update the city of owner Riley to Paris.",
                    hint: "Use WHERE name = 'Riley'.",
                    schemas: [
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "UPDATE Owners SET city = 'Paris' WHERE name = 'Riley'"
                    ],
                    blocks: ["UPDATE", "Owners", "SET", "city", "=", "'Paris'", "WHERE", "name", "=", "'Riley'", "'Berlin'", "DELETE"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Delete visits where cost is less than 20.",
                    hint: "DELETE FROM Visits WHERE cost < 20",
                    schemas: [
                        "Visits(id, animal_id, visit_date, cost)"
                    ],
                    acceptedAnswers: [
                        "DELETE FROM Visits WHERE cost < 20"
                    ],
                    blocks: ["DELETE", "FROM", "Visits", "WHERE", "cost", "<", "20", "30", "UPDATE", "SET"]
                ))),
                Slide(kind: .info(Info(
                    title: "You finished the core path",
                    sections: [
                        InfoSection(
                            title: "SQL foundations complete",
                            body: "You covered reading, filtering, sorting, grouping, joining, and writing data."
                        ),
                        InfoSection(
                            title: "Practice suggestion",
                            body: "Redo lessons in text mode and challenge yourself to write each query before using blocks."
                        )
                    ]
                )))
            ]
        )
    ]
}
