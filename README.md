# 📸 Instagram Clone Database Project

This repository contains the structured database schema and related SQL operations for an Instagram-like application. It includes the database creation script, frequently used queries, and database triggers to simulate real-world functionalities such as posting, liking, following, and commenting.

---

## 📂 Files Included

| File Name              | Description |
|------------------------|-------------|
| `IG_DB.sql`            | Main database schema. Contains table definitions for users, posts, comments, likes, follows, etc. |
| `IG _DB queries.sql`     | Useful SQL queries to interact with the database. Includes SELECTs, JOINs, aggregates, and nested queries. |
| `ig_clone_data.sql`     | Contains all the data which is required for experimentation |
| `IgDbTriggers.sql`  | SQL triggers to automate and simulate real-life behaviors such as auto-updating timestamps, notifications, etc. |
| `ig_ER_diagram.png`  | This is the screenshot of the ER diagram of the database. |
 
---

## 🚀 How to Use

### 1. 📥 Import the Database
Open your MySQL client (like MySQL Workbench, phpMyAdmin, or CLI) and run the following:

```sql
SOURCE path/to/ig_db.sql;
