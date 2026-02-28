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
                            body: "When you submit, your query is checked against valid SQL answers. If it is wrong, use hints and AI Feedback to understand exactly what to fix."
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
                            body: "SQL keywords are usually written in uppercase for readability (`SELECT`, `FROM`, `WHERE`). Additionally, correct spelling, clause order, and symbols matter."
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
                            title: "What is a schema?",
                            body: "A schema is the blueprint of a database. It defines the tables, their columns, the type of data each column stores, and how tables are connected to each other."
                        ),
                        InfoSection(
                            title: "Example tables",
                            body: "`Animals(id, name, species, age, owner_id)`\n`Owners(id, name, city)`"
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
                            body: "A standard pattern is: `SELECT ... FROM ... WHERE ...`\nThis can be extended to include: `GROUP BY ... HAVING ... ORDER BY ... LIMIT ...`"
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
                            title: "Shortcut to select all columns",
                            body: "To select all columns, use `SELECT *`. Example: `SELECT * FROM Animals`"
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
                    hint: "Think about the shortest way to select all columns from one table. Use the schema to name the table.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT * FROM Animals"
                    ],
                    blocks: ["SELECT", "*", "FROM", "Animals", "Owners", "WHERE", "all", "everything"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Select name and species from Animals.",
                    hint: "Choose two specific columns and read from the correct table. Remember to separate column names properly.",
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
                    hint: "Filter rows by a numeric comparison on the age column. Make sure the filter comes after choosing table and columns.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT * FROM Animals WHERE age > 2"
                    ],
                    blocks: ["SELECT", "*", "FROM", "Animals", "WHERE", "age", ">", "2", "3", "<", "name", "species"]
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
                    hint: "Combine two conditions: one text match and one numeric comparison. Place the conditions together with the correct logical connector.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Animals WHERE species = 'cat' AND age >= 2"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Animals", "WHERE", "species", "=", "'cat'", "AND", "age", ">=", "2", "3", "OR", "*"]
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
                    question: "Return names of the animals with the oldest first.",
                    hint: "After selecting names from the table, sort by the appropriate column in descending order.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Animals ORDER BY age DESC"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Animals", "ORDER BY", "age", "DESC", "ASC", "5", "WHERE", "age", "*"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List owner names alphabetically and show only the first 5.",
                    hint: "Sort names in ascending order, then keep only a small number of rows from the top.",
                    schemas: [
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Owners ORDER BY name ASC LIMIT 5",
                        "SELECT name FROM Owners ORDER BY name LIMIT 5"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Owners", "ORDER BY", "LIMIT", "ASC", "DESC", "5", "city", "name", "WHERE", "*"]
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
            title: "Grouping with COUNT",
            subtitle: "GROUP BY foundations",
            slides: [
                Slide(kind: .info(Info(
                    title: "First step into grouped results",
                    sections: [
                        InfoSection(
                            title: "What GROUP BY does",
                            body: "`GROUP BY` collects rows with the same value into buckets. If you group by `species`, each species becomes one bucket."
                        ),
                        InfoSection(
                            title: "What COUNT does",
                            body: "`COUNT(*)` returns how many rows are inside each bucket. Together, these answer questions like 'how many animals per species?'."
                        ),
                        InfoSection(
                            title: "Pattern to remember",
                            body: "`SELECT grouped_column, COUNT(*) FROM table GROUP BY grouped_column`\nExample that returns the number of classmates per age:\n `Classmates(name, age)`\n`SELECT age, COUNT(*) FROM Classmates GROUP BY age`"
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Count animals per species.",
                    hint: "Group rows by a category column and include a count per group in the result.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT species, COUNT(*) FROM Animals GROUP BY species"
                    ],
                    blocks: ["SELECT", "species", ",", "COUNT(*)", "FROM", "Animals", "GROUP BY", "species", "WHERE", "age", ">", "2", "DESC", "ASC"]
                ))),
                Slide(kind: .info(Info(
                    title: "Try grouping by a different column",
                    sections: [
                        InfoSection(
                            title: "Same pattern, new question",
                            body: "You can group by `city`, `owner_id`, or any column where counting by category is useful."
                        ),
                        InfoSection(
                            title: "Reading grouped output",
                            body: "Each result row now represents a category summary, not one original row from the table."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Count owners per city.",
                    hint: "Use the city column as your category: group by it and include a count for each city.",
                    schemas: [
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "SELECT city, COUNT(*) FROM Owners GROUP BY city"
                    ],
                    blocks: ["SELECT", "city", ",", "COUNT(*)", "FROM", "Owners", "GROUP BY", "city", "ORDER BY", "name", "LIMIT", "3", "ASC"]
                ))),
                Slide(kind: .info(Info(
                    title: "COUNT + GROUP BY complete",
                    sections: [
                        InfoSection(
                            title: "What you can now do",
                            body: "You can summarize raw data into category counts, which is a core reporting pattern in real dashboards."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Next lesson adds more aggregate functions like `AVG` and introduces `HAVING`."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Aggregates and HAVING",
            subtitle: "Learn AVG first, then filter groups",
            slides: [
                Slide(kind: .info(Info(
                    title: "Using AVG with GROUP BY",
                    sections: [
                        InfoSection(
                            title: "What AVG does",
                            body: "`AVG(column)` calculates the average value for a numeric column. Example: `AVG(age)` means average age."
                        ),
                        InfoSection(
                            title: "How to use it",
                            body: "To get one average per category, combine AVG with GROUP BY. Example: `SELECT species, AVG(age) FROM Animals GROUP BY species`."
                        ),
                        InfoSection(
                            title: "Read the result",
                            body: "Each row now represents one species and its average age, not one individual animal."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show average age per species.",
                    hint: "Calculate an average over a numeric column for each category defined by species.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT species, AVG(age) FROM Animals GROUP BY species"
                    ],
                    blocks: ["SELECT", "species", ",", "AVG(age)", "FROM", "Animals", "GROUP BY", "species", "WHERE", "age", ">", "3", "*", "ASC"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show average visit cost per animal_id.",
                    hint: "Summarize visit costs by animal: compute an average and group by the animal identifier.",
                    schemas: [
                        "Visits(id, animal_id, visit_date, cost)"
                    ],
                    acceptedAnswers: [
                        "SELECT animal_id, AVG(cost) FROM Visits GROUP BY animal_id"
                    ],
                    blocks: ["SELECT", "animal_id", ",", "AVG(cost)", "FROM", "Visits", "GROUP BY", "animal_id", "ORDER BY", "cost", "DESC", "HAVING"]
                ))),
                Slide(kind: .info(Info(
                    title: "Now add HAVING",
                    sections: [
                        InfoSection(
                            title: "What HAVING does",
                            body: "`HAVING` filters grouped rows after AVG/COUNT is calculated. It answers questions like 'which groups are above a threshold?'."
                        ),
                        InfoSection(
                            title: "WHERE vs HAVING",
                            body: "Use `WHERE` for normal rows before grouping. Use `HAVING` for grouped results after aggregation."
                        ),
                        InfoSection(
                            title: "Example pattern",
                            body: "`SELECT species, AVG(age) FROM Animals GROUP BY species HAVING AVG(age) > 3`"
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show species where average age is greater than 3.",
                    hint: "First compute an average per species, then filter the grouped results by a threshold on that average.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT species, AVG(age) FROM Animals GROUP BY species HAVING AVG(age) > 3"
                    ],
                    blocks: ["SELECT", "species", ",", "AVG(age)", "FROM", "Animals", "GROUP BY", "species", "HAVING", "AVG(age)", ">=", "3", "WHERE", "age", ">"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Show animal_id groups where average visit cost is at least 40.",
                    hint: "After grouping by the animal identifier and averaging cost, keep only groups meeting the minimum threshold.",
                    schemas: [
                        "Visits(id, animal_id, visit_date, cost)"
                    ],
                    acceptedAnswers: [
                        "SELECT animal_id, AVG(cost) FROM Visits GROUP BY animal_id HAVING AVG(cost) >= 40"
                    ],
                    blocks: ["SELECT", "animal_id", ",", "AVG(cost)", "FROM", "Visits", "GROUP BY", "animal_id", "HAVING", "AVG(cost)", ">=", "40", "WHERE", "cost", ">"]
                ))),
                Slide(kind: .info(Info(
                    title: "You now understand AVG and HAVING",
                    sections: [
                        InfoSection(
                            title: "What you can do now",
                            body: "You can summarize data with AVG and then keep only the groups that meet a condition."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Now we switch to writing data, starting with `INSERT`."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Inserting Data",
            subtitle: "INSERT INTO and VALUES",
            slides: [
                Slide(kind: .info(Info(
                    title: "Create new rows safely",
                    sections: [
                        InfoSection(
                            title: "INSERT basics",
                            body: "`INSERT INTO table (columns) VALUES (values)` adds one new row. Column order and value order must match."
                        ),
                        InfoSection(
                            title: "String values",
                            body: "Text values need single quotes, like `'Riley'` and `'Berlin'`."
                        ),
                        InfoSection(
                            title: "Good habit",
                            body: "Always specify columns explicitly instead of relying on table default order."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Insert a new owner named Riley in Berlin.",
                    hint: "Add one row by naming the target table and the specific columns, then provide matching values in order.",
                    schemas: [
                        "Owners(name, city)"
                    ],
                    acceptedAnswers: [
                        "INSERT INTO Owners (name, city) VALUES ('Riley', 'Berlin')",
                        "INSERT INTO Owners ( name , city ) VALUES ( 'Riley' , 'Berlin' )"
                    ],
                    blocks: ["INSERT", "INTO", "Owners", "(", "name", ",", "city", ")", "VALUES", "(", "'Riley'", ",", "'Berlin'", ")", "UPDATE", "SET"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Insert a new owner named Luna in Madrid.",
                    hint: "Repeat the same insertion pattern: specify columns, then provide values in the same order.",
                    schemas: [
                        "Owners(name, city)"
                    ],
                    acceptedAnswers: [
                        "INSERT INTO Owners (name, city) VALUES ('Luna', 'Madrid')",
                        "INSERT INTO Owners ( name , city ) VALUES ( 'Luna' , 'Madrid') "
                    ],
                    blocks: ["INSERT", "INTO", "Owners", "(", "name", ",", "city", ")", "VALUES", "(", "'Luna'", ",", "'Madrid'", ")", "'Riley'", "'Berlin'", "DELETE"]
                ))),
                Slide(kind: .info(Info(
                    title: "INSERT complete",
                    sections: [
                        InfoSection(
                            title: "What you gained",
                            body: "You can now add new rows with controlled column mapping and correct string quoting."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Next lesson: modifying existing rows with `UPDATE` and `WHERE`."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Updating Data",
            subtitle: "UPDATE, SET, and WHERE",
            slides: [
                Slide(kind: .info(Info(
                    title: "Modify existing rows",
                    sections: [
                        InfoSection(
                            title: "UPDATE pattern",
                            body: "`UPDATE table SET column = value WHERE condition` changes matching rows."
                        ),
                        InfoSection(
                            title: "Critical warning",
                            body: "If you omit `WHERE`, every row is updated. For learning and production, always verify your filter."
                        ),
                        InfoSection(
                            title: "Debug tactic",
                            body: "Write the `WHERE` condition first as a SELECT to confirm the target rows before running UPDATE."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Update the city of owner Riley to Paris.",
                    hint: "Change one column for matching rows only. Use a precise filter that identifies the correct owner.",
                    schemas: [
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "UPDATE Owners SET city = 'Paris' WHERE name = 'Riley'"
                    ],
                    blocks: ["UPDATE", "Owners", "SET", "city", "=", "'Paris'", "WHERE", "name", "=", "'Riley'", "'Berlin'", "DELETE", "FROM", "*"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Update all cats to age 4.",
                    hint: "Update a numeric column for rows that match a specific category value. Be sure to include the filter.",
                    schemas: [
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "UPDATE Animals SET age = 4 WHERE species = 'cat'"
                    ],
                    blocks: ["UPDATE", "Animals", "SET", "age", "=", "4", "WHERE", "species", "=", "'cat'", "'dog'", "3", "INSERT", "INTO"]
                ))),
                Slide(kind: .info(Info(
                    title: "UPDATE complete",
                    sections: [
                        InfoSection(
                            title: "Your safety checklist",
                            body: "Table, column, new value, then precise WHERE condition."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Next lesson: deleting rows carefully with `DELETE` and filters."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Deleting Data",
            subtitle: "DELETE with precise filters",
            slides: [
                Slide(kind: .info(Info(
                    title: "Remove rows intentionally",
                    sections: [
                        InfoSection(
                            title: "DELETE pattern",
                            body: "`DELETE FROM table WHERE condition` removes only matching rows."
                        ),
                        InfoSection(
                            title: "Most dangerous omission",
                            body: "Without `WHERE`, the table is emptied. This is a common beginner and production mistake."
                        ),
                        InfoSection(
                            title: "Safer workflow",
                            body: "Test your condition using a SELECT first, then run DELETE with the same WHERE clause."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Delete visits where cost is less than 20.",
                    hint: "Remove rows from the correct table using a numeric comparison in your filter.",
                    schemas: [
                        "Visits(id, animal_id, visit_date, cost)"
                    ],
                    acceptedAnswers: [
                        "DELETE FROM Visits WHERE cost < 20"
                    ],
                    blocks: ["DELETE", "FROM", "Visits", "WHERE", "cost", "<", "20", "30", "UPDATE", "SET"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Delete owners in Berlin.",
                    hint: "Delete only rows that match a specific text value in the city column.",
                    schemas: [
                        "Owners(id, name, city)"
                    ],
                    acceptedAnswers: [
                        "DELETE FROM Owners WHERE city = 'Berlin'"
                    ],
                    blocks: ["DELETE", "FROM", "Owners", "WHERE", "city", "=", "'Berlin'", "'Paris'", "name", "UPDATE", "SET"]
                ))),
                Slide(kind: .info(Info(
                    title: "DELETE complete",
                    sections: [
                        InfoSection(
                            title: "Write operations done",
                            body: "You can now insert, update, and delete with safer habits and explicit filters."
                        ),
                        InfoSection(
                            title: "Next",
                            body: "Now you will learn subqueries, where one SELECT is nested inside another."
                        )
                    ]
                )))
            ]
        ),
        Lesson(
            title: "Subqueries",
            subtitle: "One query inside another",
            slides: [
                Slide(kind: .info(Info(
                    title: "How subqueries work",
                    sections: [
                        InfoSection(
                            title: "Start with a normal query",
                            body: "Base query: `SELECT * FROM Students WHERE score > 80`. Here, `80` is a fixed number."
                        ),
                        InfoSection(
                            title: "Replace the fixed number with a query",
                            body: "Subquery version: `SELECT * FROM Students WHERE score > (SELECT AVG(score) FROM Students)`. The part inside parentheses computes the average score first."
                        ),
                        InfoSection(
                            title: "What changes vs what stays",
                            body: "The outer structure usually stays similar (`SELECT ... FROM ... WHERE ...`). The part after `>` changes from a hardcoded value to a computed value from the inner query."
                        ),
                        InfoSection(
                            title: "Execution order",
                            body: "Step 1: run `SELECT AVG(score) FROM Students` and get one number. Step 2: use that number in the outer WHERE filter."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Return students whose score is above the average score.",
                    hint: "Compare each student's score to a single value computed by an inner query over all students.",
                    schemas: [
                        "Students(id, name, score)"
                    ],
                    acceptedAnswers: [
                        "SELECT * FROM Students WHERE score > (SELECT AVG(score) FROM Students)",
                        "SELECT * FROM Students WHERE score > ( SELECT AVG(score) FROM Students )"
                    ],
                    blocks: ["SELECT", "*", "FROM", "Students", "WHERE", "score", ">", "(", "SELECT", "AVG(score)", "FROM", "Students", ")", "<", "COUNT(*)"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "Return student names whose score is below the average score.",
                    hint: "Select only the name column and filter by comparing to an average computed in a subquery.",
                    schemas: [
                        "Students(id, name, Score)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Students WHERE Score < (SELECT AVG(Score) FROM Students)",
                        "SELECT name FROM Students WHERE Score < ( SELECT AVG(Score) FROM Students )"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Students", "WHERE", "Score", "<", "(", "SELECT", "AVG(Score)", "FROM", "Students", ")", ">", "COUNT(*)"]
                ))),
                Slide(kind: .info(Info(
                    title: "Now learn IN (subquery)",
                    sections: [
                        InfoSection(
                            title: "When IN is useful",
                            body: "Use `IN (SELECT ...)` when the inner query returns a list of values, like many IDs."
                        ),
                        InfoSection(
                            title: "Example",
                            body: "`SELECT name FROM Owners WHERE id IN (SELECT owner_id FROM Animals WHERE age > 5)`"
                        ),
                        InfoSection(
                            title: "Why it works",
                            body: "The inner query returns owner IDs. The outer query keeps owners whose `id` is in that returned list."
                        )
                    ]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List owner names who own at least one animal older than 5.",
                    hint: "Filter owners by checking if their id appears in a list produced from another table with a condition.",
                    schemas: [
                        "Owners(id, name, city)",
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Owners WHERE id IN (SELECT owner_id FROM Animals WHERE age > 5)",
                        "SELECT name FROM Owners WHERE id IN ( SELECT owner_id FROM Animals WHERE age > 5 )"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Owners", "WHERE", "id", "IN", "(", "SELECT", "owner_id", "FROM", "Animals", "WHERE", "age", ">", "5", ")", "city", "'London'", "JOIN"]
                ))),
                Slide(kind: .activity(Activity(
                    question: "List owner names who own at least one cat.",
                    hint: "Use a subquery that returns owner identifiers for rows matching a specific species, then filter owners by membership in that list.",
                    schemas: [
                        "Owners(id, name, city)",
                        "Animals(id, name, species, age, owner_id)"
                    ],
                    acceptedAnswers: [
                        "SELECT name FROM Owners WHERE id IN (SELECT owner_id FROM Animals WHERE species = 'cat')",
                        "SELECT name FROM Owners WHERE id IN ( SELECT owner_id FROM Animals WHERE species = 'cat' )"
                    ],
                    blocks: ["SELECT", "name", "FROM", "Owners", "WHERE", "id", "IN", "(", "SELECT", "owner_id", "FROM", "Animals", "WHERE", "species", "=", "'cat'", ")", "'dog'", "age", ">", "5"]
                ))),
                Slide(kind: .info(Info(
                    title: "Subqueries complete",
                    sections: [
                        InfoSection(
                            title: "What you can do now",
                            body: "You can use one query to compute a value or set, then use that result in another query."
                        ),
                        InfoSection(
                            title: "Final lesson",
                            body: "Next: complex joins across multiple tables with filtering and ordering together."
                        )
                    ]
                )))
            ]
        )//,
//        Lesson(
//            title: "Complex Joining",
//            subtitle: "Build multi-table queries step by step",
//            slides: [
//                Slide(kind: .info(Info(
//                    title: "How to build joins without getting lost",
//                    sections: [
//                        InfoSection(
//                            title: "Start from one base table",
//                            body: "Begin with `FROM Animals`. Then add one join at a time. Do not try to write a 3-table query all at once."
//                        ),
//                        InfoSection(
//                            title: "Join formula",
//                            body: "Each join follows this shape: `INNER JOIN OtherTable ON left_key = right_key`. Example: `INNER JOIN Owners ON Animals.owner_id = Owners.id`."
//                        ),
//                        InfoSection(
//                            title: "Concrete build-up",
//                            body: "Step 1: `SELECT Animals.name FROM Animals`\nStep 2: `... INNER JOIN Owners ON Animals.owner_id = Owners.id`\nStep 3: add owner columns in SELECT."
//                        ),
//                        InfoSection(
//                            title: "Use table-qualified columns",
//                            body: "Write columns like `Animals.name` and `Owners.name` so SQL knows exactly which table each column comes from."
//                        )
//                    ]
//                ))),
//                Slide(kind: .activity(Activity(
//                    question: "List each animal name with its owner name.",
//                    hint: "Join Animals to Owners on Animals.owner_id = Owners.id.",
//                    schemas: [
//                        "Animals(id, name, species, age, owner_id)",
//                        "Owners(id, name, city)"
//                    ],
//                    acceptedAnswers: [
//                        "SELECT Animals.name, Owners.name FROM Animals INNER JOIN Owners ON Animals.owner_id = Owners.id"
//                    ],
//                    blocks: ["SELECT", "Animals.name", ",", "Owners.name", "FROM", "Animals", "INNER JOIN", "Owners", "ON", "Animals.owner_id", "=", "Owners.id", "WHERE", "Owners.city", "'London'", "LEFT JOIN"]
//                ))),
//                Slide(kind: .activity(Activity(
//                    question: "List animal name and owner city.",
//                    hint: "Same join as before, but select Owners.city.",
//                    schemas: [
//                        "Animals(id, name, species, age, owner_id)",
//                        "Owners(id, name, city)"
//                    ],
//                    acceptedAnswers: [
//                        "SELECT Animals.name, Owners.city FROM Animals INNER JOIN Owners ON Animals.owner_id = Owners.id"
//                    ],
//                    blocks: ["SELECT", "Animals.name", ",", "Owners.city", "FROM", "Animals", "INNER JOIN", "Owners", "ON", "Animals.owner_id", "=", "Owners.id", "Owners.name", "ORDER BY", "DESC"]
//                ))),
//                Slide(kind: .info(Info(
//                    title: "Add a third table",
//                    sections: [
//                        InfoSection(
//                            title: "Chain joins",
//                            body: "After joining Animals to Owners, you can join Visits too: `INNER JOIN Visits ON Visits.animal_id = Animals.id`."
//                        ),
//                        InfoSection(
//                            title: "Clause order",
//                            body: "A reliable order is: `SELECT` -> `FROM` -> `JOIN` -> `WHERE` -> `ORDER BY`."
//                        ),
//                        InfoSection(
//                            title: "Read it like a sentence",
//                            body: "From Animals, attach matching Owners, then attach matching Visits, then filter/sort."
//                        )
//                    ]
//                ))),
//                Slide(kind: .activity(Activity(
//                    question: "List animal name, owner city, and visit cost.",
//                    hint: "Join Animals->Owners, then Animals->Visits.",
//                    schemas: [
//                        "Animals(id, name, species, age, owner_id)",
//                        "Owners(id, name, city)",
//                        "Visits(id, animal_id, visit_date, cost)"
//                    ],
//                    acceptedAnswers: [
//                        "SELECT Animals.name, Owners.city, Visits.cost FROM Animals INNER JOIN Owners ON Animals.owner_id = Owners.id INNER JOIN Visits ON Visits.animal_id = Animals.id"
//                    ],
//                    blocks: ["SELECT", "Animals.name", ",", "Owners.city", ",", "Visits.cost", "FROM", "Animals", "INNER JOIN", "Owners", "ON", "Animals.owner_id", "=", "Owners.id", "INNER JOIN", "Visits", "ON", "Visits.animal_id", "=", "Animals.id", "WHERE", "Visits.cost", ">", "50"]
//                ))),
//                Slide(kind: .activity(Activity(
//                    question: "Show animal name and visit cost for visits above 50.",
//                    hint: "Join Animals and Visits, then add WHERE Visits.cost > 50.",
//                    schemas: [
//                        "Animals(id, name, species, age, owner_id)",
//                        "Visits(id, animal_id, visit_date, cost)"
//                    ],
//                    acceptedAnswers: [
//                        "SELECT Animals.name, Visits.cost FROM Animals INNER JOIN Visits ON Visits.animal_id = Animals.id WHERE Visits.cost > 50"
//                    ],
//                    blocks: ["SELECT", "Animals.name", ",", "Visits.cost", "FROM", "Animals", "INNER JOIN", "Visits", "ON", "Visits.animal_id", "=", "Animals.id", "WHERE", "Visits.cost", ">", "50", "ORDER BY", "DESC", "LIMIT", "5"]
//                ))),
//                Slide(kind: .info(Info(
//                    title: "Debugging join mistakes",
//                    sections: [
//                        InfoSection(
//                            title: "Too many rows",
//                            body: "Usually means the `ON` condition is wrong or missing. Check you matched key columns correctly."
//                        ),
//                        InfoSection(
//                            title: "Wrong columns",
//                            body: "If you see ambiguous names, qualify columns with table names like `Owners.name` instead of `name`."
//                        ),
//                        InfoSection(
//                            title: "Debug strategy",
//                            body: "Run a simpler version first (one JOIN), verify output, then add WHERE/ORDER BY as the final step."
//                        )
//                    ]
//                ))),
//                Slide(kind: .activity(Activity(
//                    question: "Show animal name and visit cost for visits above 50, highest cost first.",
//                    hint: "Use WHERE Visits.cost > 50 then ORDER BY Visits.cost DESC.",
//                    schemas: [
//                        "Animals(id, name, species, age, owner_id)",
//                        "Visits(id, animal_id, visit_date, cost)"
//                    ],
//                    acceptedAnswers: [
//                        "SELECT Animals.name, Visits.cost FROM Animals INNER JOIN Visits ON Visits.animal_id = Animals.id WHERE Visits.cost > 50 ORDER BY Visits.cost DESC"
//                    ],
//                    blocks: ["SELECT", "Animals.name", ",", "Visits.cost", "FROM", "Animals", "INNER JOIN", "Visits", "ON", "Visits.animal_id", "=", "Animals.id", "WHERE", "Visits.cost", ">", "50", "ORDER BY", "Visits.cost", "DESC", "ASC", "LIMIT", "5"]
//                ))),
//                Slide(kind: .info(Info(
//                    title: "You finished the full learning path",
//                    sections: [
//                        InfoSection(
//                            title: "What you now know",
//                            body: "You can design multi-table queries by building joins step by step, then adding filters and sorting safely."
//                        ),
//                        InfoSection(
//                            title: "How to level up",
//                            body: "Redo this lesson in text mode and write each query from memory before checking hints."
//                        ),
//                        InfoSection(
//                            title: "Engineer mindset",
//                            body: "When stuck, reduce complexity: one table, one join, then one clause at a time."
//                        )
//                    ]
//                )))
//            ]
//        )
    ]
}

