# European-Football-Data-Engineering
Project for the course: Introduction to Data Engineering.

![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white) ![MongoDB](https://img.shields.io/badge/MongoDB-%234ea94b.svg?style=for-the-badge&logo=mongodb&logoColor=white) ![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

This project implements a complete Data Engineering Pipeline analyzing football statistics from Europe's Top 5 Leagues (2023-2024 Season).

Dataset From: https://www.kaggle.com/datasets/kamrangayibov/football-data-european-top-5-leagues/data

The primary objective was to architect a robust relational database (3NF), execute complex analytical queries, and engineer a structured migration strategy to a NoSQL (MongoDB) environment to optimize read performance for match event data.

## 🚀 Key Features

* **Relational Data Modeling:** Designed a normalized **MySQL** schema to manage complex entities including Leagues, Teams, Players, Match Events, and Refereeing assignments, ensuring strict referential integrity.
* **Advanced SQL Analysis:** Implemented high-level data extraction strategies:
    * Multi-table `JOINs` (3+ tables) for cross-referencing match outcomes.
    * Hierarchical aggregation using `GROUP BY` with `ROLLUP` to generate multi-level summary reports (Team vs. League totals).
    * Subqueries and filtering for specific performance metrics.
* **NoSQL Migration Pipeline:** Engineered a transformation pipeline to migrate data from MySQL to **MongoDB**.
    * Redesigned the schema from tabular to document-oriented, utilizing **embedding strategies** (e.g., nesting scores within matches) to reduce query latency.
    * Translated complex SQL logic into **MongoDB Aggregation Pipelines** (`$lookup`, `$unwind`, `$project`).
* **Application Integration:** Developed Java-based query implementations to bridge the database logic with application-layer requirements.

## 🛠️ Tech Stack

* **Relational Database:** MySQL (Schema Design, Constraints, Stored Procedures).
* **NoSQL Database:** MongoDB (Document Modeling, Aggregation Framework).
* **ETL Tools:** MongoDB Relational Migrator.
* **Languages:** SQL, Java (Driver implementation), Python (Data processing).
