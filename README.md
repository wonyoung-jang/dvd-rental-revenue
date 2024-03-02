## DVD Rental Revenue Insights

This project delves into the analysis of film categories and their revenue contributions in a DVD rental business, leveraging PostgreSQL for comprehensive database management and data analysis.

## Table of Contents
- [Technologies Used](#technologies-used)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [About](#about)
- [License](#license)

## Technologies Used
- PostgreSQL
- [pgAdmin 4](https://www.pgadmin.org/download/)

## Features
- Creation of detailed and summary tables for revenue data analysis.
- Data transformation procedures to facilitate insightful reporting.
- Revenue analysis segmented by film categories.

## Installation
1. Install PostgreSQL and pgAdmin 4.
2. Utilize the supplied SQL scripts to establish and populate the database.

## Usage
- Employ the SQL scripts to generate revenue reports.
- Use pgAgent to automate the monthly execution of the stored procedure, enhancing data freshness and strategic analysis.

## About

### Data
Utilizing data from [PostgreSQL's Sample DVD Rental Database](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/), the project constructs a comprehensive revenue analysis framework.

![](images/dvd-rental-data-used.jpg)

Key elements include variable identification, report and database table associations, datatype clarification, and variable descriptions, ensuring a thorough understanding and utilization of the data for revenue analysis.

### Tables and Fields from the dvdrental Database
The project leverages specific tables from the dvdrental database to create detailed and summary reports, focusing on essential fields like `name` from `category` and `amount` from `payment`. These fields are integral to both reports, providing a consistent data framework, while other fields are selectively used to enrich the detailed report with granular data.

### Business Usage
The detailed and summary reports serve distinct purposes, from offering immediate analytical insights to facilitating long-term strategic planning. They enable targeted inventory adjustments and strategic decision-making based on revenue trends across different film categories.

### Report Refresh Cycle and Strategic Timing
The chosen monthly refresh cycle for the report is a strategic decision to provide timely and relevant data for decision-making, balancing the need for up-to-date information with the natural variability of the rental market.

## License
[MIT License](LICENSE)
