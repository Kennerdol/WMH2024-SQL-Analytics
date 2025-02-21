# Wusakile-Hospital-2024-SQL-Analytics

## Table of Content
  - [Project Overview](#project-overview)
  - [Why This Project](#why-this-project)
  - [Objectives and Features](#objectives-and-features)
  - [Tools](#tools)
  - [Project Files](#project-files)
  - [Data Source](#data-source)
  - [How to Use This Project](#how-to-use-this-project)
  - [Power BI Result Screenshot](#power-bi-result-screenshot)
  - [Author](#author)
  - [License](#license)

## Project Overview
Wusakile Hospital 2024 SQL Analytics is a data-driven project that analyzes hospital operations, patient records, and medical services using SQL. The project includes an Excel dataset (WusakileHospital2024.xlsx) containing raw hospital data and a SQL script (WusakileHospital2024.sql) for database creation and analysis.

## Why This Project?
Healthcare institutions generate vast amounts of data daily, but critical insights may be overlooked without proper analysis. This project leverages SQL analytics to provide actionable insights that enhance patient care, optimize hospital administration, and improve financial management.

## Objectives and Features
- Data Structuring: Convert hospital records into a well-organized relational database.
- Patient Data Analysis: Understand patient demographics, visit patterns, and common diagnoses.
- Hospital Performance Metrics: Evaluate doctor workloads, hospital efficiency, and service delivery.
- Query Optimization: Use optimized SQL queries for faster and more insightful data retrieval.
- Decision-Making Support: Generate insights that help hospital administrators improve operations.

## Tools
- MSSQL Management Studio - Data cleaning and analysis
- Git and Github - Version control
  
## Project Files
- 👉[WusakileHospital2024.xlsb](https://github.com/Kennerdol/Wusakile-Hospital-2024-SQL-Analytics/blob/main/WusakileHospital2024.xlsb) – Original dataset containing hospital-related information.
- 👉[WusakileHospital2024.sql](https://github.com/Kennerdol/Wusakile-Hospital-2024-SQL-Analytics/blob/main/WusakileHospital2024.sql) – SQL script for dataset manipulation and analytical queries.
- 👉[README.md](https://github.com/Kennerdol/Wusakile-Hospital-2024-SQL-Analytics/edit/main/README.md)– Documentation for project setup, usage, and insights.
- 👉[License](https://github.com/Kennerdol/Wusakile-Hospital-2024-SQL-Analytics/blob/main/License.txt) - Contains the CC BY-NC 4.0 License under which this project is distributed.

## Data Source
The original data for the project was obtained from the hospital management system (Proclin).

## How to Use This Project

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

## Power BI Result Screenshot
    ![](/WMH2024.png)
## Author
[Kennedy Mulenga](https://www.linkedin.com/in/kennedy-mulenga-675a32169/)

## License
This project is licensed under the Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) License. 
See the [LICENSE](https://github.com/Kennerdol/Wusakile-Hospital-2024-SQL-Analytics/blob/main/License.txt) file for full details.
