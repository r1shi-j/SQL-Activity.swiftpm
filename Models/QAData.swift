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
                    title: "What SQL is and why people use it",
                    sections: [
                        InfoSection(
                            title: "SQL asks questions about data",
                            body: "SQL stands for Structured Query Language. You use it to ask a database questions like: 'Which animals are older than 2?' or 'How many owners live in London?'"
                        ),
                        InfoSection(
                            title: "Think in tables",
                            body: "Databases store data in tables. Tables have columns (like name, age, city) and rows (actual records). SQL helps you choose columns, filter rows, sort results, and combine multiple tables."
                        ),
                        InfoSection(
                            title: "The goal of this app",
                            body: "You will learn SQL by building real queries. The app starts simple, then progressively adds filtering, sorting, grouping, joins, and data changes."
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "How to solve an activity",
                    sections: [
                        InfoSection(
                            title: "Build your query",
                            body: "Use blocks to build SQL in the correct order. Tap blocks to move them between areas. Long-press and drag to reorder or move blocks across sections."
                        ),
                        InfoSection(
                            title: "Then submit",
                            body: "When you submit, your query is checked against valid SQL answers. If it is wrong, use Hint and AI Feedback to understand exactly what to fix."
                        ),
                        InfoSection(
                            title: "You can switch modes",
                            body: "Block mode is great for learning structure. Text mode is great for writing raw SQL once you feel more confident."
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "Syntax and accuracy matter",
                    sections: [
                        InfoSection(
                            title: "Order and punctuation matter",
                            body: "SQL has a grammar. For example, `SELECT name FROM Animals WHERE age > 2` is valid, but putting clauses in the wrong order can break the query."
                        ),
                        InfoSection(
                            title: "Uppercase is convention",
                            body: "SQL keywords are usually written in uppercase for readability (`SELECT`, `FROM`, `WHERE`), but many databases accept lowercase too. What always matters is correct spelling, clause order, and symbols."
                        ),
                        InfoSection(
                            title: "Quoted text values",
                            body: "String values use quotes, like `species = 'cat'`. Numbers typically do not use quotes, like `age > 2`."
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
                    title: "Understand the schema first",
                    sections: [
                        InfoSection(
                            title: "Example tables",
                            body: "Animals(id, name, species, age, owner_id)\nOwners(id, name, city)"
                        ),
                        InfoSection(
                            title: "How to read this",
                            body: "`owner_id` in Animals links to `id` in Owners. That relationship is what lets us JOIN these tables later."
                        ),
                        InfoSection(
                            title: "Why schema matters",
                            body: "Most SQL mistakes come from using a column that does not exist or confusing similarly named columns across tables."
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "Typical query flow",
                    sections: [
                        InfoSection(
                            title: "Common clause pattern",
                            body: "A standard pattern is: `SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY ... LIMIT ...`"
                        ),
                        InfoSection(
                            title: "Build incrementally",
                            body: "Start with a minimal query, run it mentally, then add one clause at a time. This is the easiest way to debug and learn."
                        ),
                        InfoSection(
                            title: "Quick example",
                            body: "`SELECT name FROM Animals`\nthen add filter:\n`SELECT name FROM Animals WHERE age > 2`\nthen add sorting:\n`SELECT name FROM Animals WHERE age > 2 ORDER BY age DESC`"
                        )
                    ]
                ))),
                Slide(kind: .info(Info(
                    title: "How to think like a SQL engineer",
                    sections: [
                        InfoSection(
                            title: "Ask one precise question",
                            body: "Before writing SQL, state your question clearly in plain English. Example: 'Show the 3 oldest animals.'"
                        ),
                        InfoSection(
                            title: "Map question to clauses",
                            body: "Which columns do I need? (SELECT)\nWhich table(s)? (FROM/JOIN)\nAny conditions? (WHERE)\nAny ranking? (ORDER BY/LIMIT)"
                        ),
                        InfoSection(
                            title: "Now start activities",
                            body: "The next lessons will introduce one concept at a time, then test you immediately, similar to Duolingo-style progression."
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
                    title: "Choose columns and source table",
                    sections: [
                        InfoSection(
                            title: "SELECT controls output",
                            body: "SELECT decides what appears in your result. Example: `SELECT name, species` returns only those two columns."
                        ),
                        InfoSection(
                            title: "FROM controls source",
                            body: "FROM tells SQL where to read data. Example: `FROM Animals` means read rows from the Animals table."
                        ),
                        InfoSection(
                            title: "First pattern",
                            body: "Your first core pattern is: `SELECT columns FROM table`. You will use this in almost every query."
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
                    title: "What you just learned",
                    sections: [
                        InfoSection(
                            title: "Two essential clauses",
                            body: "`SELECT` + `FROM` is the foundation of SQL. Everything else extends this base."
                        ),
                        InfoSection(
                            title: "Readability tip",
                            body: "Many developers format as:\n`SELECT name, species`\n`FROM Animals`\nLine breaks make longer queries easier to scan."
                        ),
                        InfoSection(
                            title: "Next concept",
                            body: "Now you will learn to reduce rows with `WHERE` so you only keep relevant records."
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
                    title: "Use WHERE to keep only matching rows",
                    sections: [
                        InfoSection(
                            title: "Basic filter",
                            body: "Example: `SELECT * FROM Animals WHERE age > 2` returns only animals older than 2."
                        ),
                        InfoSection(
                            title: "Text comparisons",
                            body: "Example: `WHERE species = 'cat'` filters rows where species is exactly cat."
                        ),
                        InfoSection(
                            title: "Combine conditions",
                            body: "Use `AND` when both conditions must be true. Example: `WHERE species = 'cat' AND age >= 2`."
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
                    title: "Common WHERE mistakes",
                    sections: [
                        InfoSection(
                            title: "Wrong value type",
                            body: "Numbers are numeric (`age > 2`), text is quoted (`species = 'cat'`). Mixing these can lead to incorrect results."
                        ),
                        InfoSection(
                            title: "Missing logical operator",
                            body: "If you have multiple conditions, you usually need `AND` or `OR` between them."
                        ),
                        InfoSection(
                            title: "Check intent",
                            body: "Ask: 'Do I want both conditions true (`AND`) or either condition true (`OR`)?'"
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
                    title: "Filtering confidence",
                    sections: [
                        InfoSection(
                            title: "You can target data",
                            body: "With `WHERE`, your query can answer precise business questions instead of returning everything."
                        ),
                        InfoSection(
                            title: "Real-world use",
                            body: "Dashboards, reports, and search features all rely heavily on filtering logic."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "You will now sort and limit results to get top-N answers."
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
                    title: "Control result order and size",
                    sections: [
                        InfoSection(
                            title: "ORDER BY",
                            body: "`ORDER BY age DESC` means highest age first. `ASC` means lowest first."
                        ),
                        InfoSection(
                            title: "LIMIT",
                            body: "`LIMIT 3` keeps only the first 3 rows after sorting."
                        ),
                        InfoSection(
                            title: "Typical combination",
                            body: "Top-N pattern: `SELECT ... FROM ... ORDER BY metric DESC LIMIT N`."
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
                    title: "Order first, then limit",
                    sections: [
                        InfoSection(
                            title: "Why clause order matters",
                            body: "If you limit before deciding order, you may keep the wrong rows. The intended flow is sort first, then keep top N."
                        ),
                        InfoSection(
                            title: "Example",
                            body: "`SELECT name FROM Animals ORDER BY age DESC LIMIT 3` means 'give me the 3 oldest animals'."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "You will now summarize rows with aggregate functions and grouping."
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
                    title: "From raw rows to summaries",
                    sections: [
                        InfoSection(
                            title: "Aggregate functions",
                            body: "`COUNT(*)` counts rows, `AVG(age)` calculates average age, `SUM(cost)` adds values, and so on."
                        ),
                        InfoSection(
                            title: "GROUP BY",
                            body: "GROUP BY creates one result row per group. Example: one row per species."
                        ),
                        InfoSection(
                            title: "HAVING",
                            body: "HAVING filters grouped results. Think: WHERE filters rows before grouping, HAVING filters groups after grouping."
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
                    title: "Summary queries are powerful",
                    sections: [
                        InfoSection(
                            title: "Business insight",
                            body: "Grouping turns many detailed rows into concise insight, such as 'which species appears most often'."
                        ),
                        InfoSection(
                            title: "Mental model",
                            body: "`SELECT group_column, AGG(value)` + `GROUP BY group_column` is your standard aggregation pattern."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Now you will combine related tables with JOIN."
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
                    title: "Combine related tables",
                    sections: [
                        InfoSection(
                            title: "Why join",
                            body: "Some answers require data from multiple tables. Example: animal name (Animals) plus owner name (Owners)."
                        ),
                        InfoSection(
                            title: "INNER JOIN",
                            body: "INNER JOIN keeps rows that match in both tables."
                        ),
                        InfoSection(
                            title: "ON clause",
                            body: "ON defines how rows match. Example: `Animals.owner_id = Owners.id`."
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
                    title: "Join then filter",
                    sections: [
                        InfoSection(
                            title: "Clause placement",
                            body: "JOIN belongs in the FROM section, and WHERE can be added after JOIN to filter the combined rows."
                        ),
                        InfoSection(
                            title: "Example",
                            body: "`SELECT Animals.name, Owners.name FROM Animals INNER JOIN Owners ON Animals.owner_id = Owners.id WHERE Owners.city = 'London'`"
                        ),
                        InfoSection(
                            title: "Debugging tip",
                            body: "If a join returns too many/few rows, first verify your ON condition references the correct keys."
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
                    title: "Relational SQL unlocked",
                    sections: [
                        InfoSection(
                            title: "What changed",
                            body: "You are now querying across relationships, which is a core skill in almost every production database."
                        ),
                        InfoSection(
                            title: "Pattern to remember",
                            body: "`SELECT ... FROM A INNER JOIN B ON ... WHERE ...`"
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Final lesson: modifying data safely with INSERT, UPDATE, and DELETE."
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
                    title: "Write data carefully",
                    sections: [
                        InfoSection(
                            title: "INSERT",
                            body: "INSERT creates new rows. Example: `INSERT INTO Owners (name, city) VALUES ('Riley', 'Berlin')`."
                        ),
                        InfoSection(
                            title: "UPDATE",
                            body: "UPDATE modifies existing rows. Always pair with WHERE unless you intentionally want to update every row."
                        ),
                        InfoSection(
                            title: "DELETE",
                            body: "DELETE removes rows. Without WHERE, you remove all rows in the table."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Insert a new owner named Riley in Berlin.",
                    hint: "Provide columns and then VALUES in the same order.",
                    schemas: [
                        "Owners(name, city)"
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
                            title: "Full SQL foundation",
                            body: "You have practiced reading, filtering, sorting, grouping, joining, and writing data. That is a strong beginner-to-intermediate SQL base."
                        ),
                        InfoSection(
                            title: "How to keep improving",
                            body: "Redo activities in text mode, then try writing each query from memory before checking hints. Spaced repetition will make syntax and patterns stick."
                        ),
                        InfoSection(
                            title: "Engineer habit",
                            body: "When queries fail, inspect schema, verify clause order, and simplify to a minimal version. Build back up step by step."
                        )
                    ]
                )))
            ]
        )
    ]
}
