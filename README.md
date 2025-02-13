# Wusakile-Hospital-2024-SQL-Analytics
## SQL project for Wusakile Hospital 2024 data analysis and reporting

Wusakile Hospital 2024 SQL Analytics is a data-driven project designed to analyze hospital operations, patient records, and medical services using SQL. The project includes an Excel dataset (wusakileHospital2024.xlsx) containing raw hospital data and a SQL script (wusakilehospital.sql) for database creation and data analysis.

## Why This Project?
Healthcare institutions generate vast amounts of data daily, but without proper analysis, critical insights may be overlooked. This project leverages SQL analytics to provide actionable insights that enhance patient care, optimize hospital administration, and improve financial management.

## Objectives and Features
- Data Structuring: Convert hospital records into a well-organized relational database.
- Patient Data Analysis: Understand patient demographics, visit patterns, and common diagnoses.
- Hospital Performance Metrics: Evaluate doctor workloads, hospital efficiency, and service delivery.
- Query Optimization: Use optimized SQL queries for faster and more insightful data retrieval.
- Decision-Making Support: Generate insights that help hospital administrators improve operations.

## Project Files
- wusakileHospital2024.xlsx – Original dataset containing hospital-related information.
- wusakileHospital.sql – SQL script for dataset manipulation and analytical queries.
- README.md 👉[View](https://github.com/Kennerdol/Wusakile-Hospital-2024-SQL-Analytics/edit/main/README.md)👈– Documentation for project setup, usage, and insights.

## Data Source
The original data for the project was obtained from the hospital management system (Proclin).

## Instructions: How to Use This Project

1. Clone the Repository from GitHub
- Open your terminal or command prompt.
- Run the following command to clone the repository
  ```sh
   https://github.com/Kennerdol/Wusakile-Hospital-2024-SQL-Analytics.git
  ```

2. Set Up the Database:
- Ensure you have MSSQL Server installed.
- Open your database management tool MSSQL Server Management Studio.
- Create a new database and select it:
  ```sql
  CREATE DATABASE Portfolio;
  ```
  ```sql
  USE Portfolio;
  ```
- Force MSSQL MS to interpret the date format as dd-mm-yyyy by running:
  ```sql
  SET DATEFORMAT dmy;
  ```
  
3. Import the SQL Script:
- Run the wusakileHospital.sql file to create tables and insert data.
- Use the external import export tool in Management Studio for 64Bit PC or direct import export for 32Bit PC

4. Explore the Data:
- Run SQL queries to see the overview of the imported data.
   ```sql
    SELECT * FROM WusakileHospital2024;
   ```
   
5. Explore the Data:
- Create a new permant table(WMH2024) from the original wusakileHospital2024 table with formated columns:
   ```sql
    CREATE TABLE WMH2024([specify colums]);
   ```

6. Insert data from the WusakileHospital2024 table:
     ```sql
       INSERT INTO WMH2024
         SELECT [Specify columns]
     FROM WusakileHospital2024;
    ```

7. Explore and run the queries (WusakileHospital2024.sql)
     ```sql
       SELECT * FROM WMH2024;
    ```
8. Modify & Extend the Analysis:
- Create additional queries based on your specific interests.
- Optimize queries for better performance if dealing with large datasets.

## Author
[Kennedy Mulenga](https://github.com/Kennerdol)

## Licence
This project is licensed under the MIT License - see the [LICENSE] file for details.
