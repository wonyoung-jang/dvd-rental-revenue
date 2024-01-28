# DVD Rental Revenue Insights

## Introduction
This project focuses on analyzing film categories and their revenue contributions in a DVD rental business, utilizing PostgreSQL for database management and data analysis.

## Technologies Used
- PostgreSQL
- [pgAdmin 4](https://www.pgadmin.org/download/)

## Features
- Detailed and summary table creation for revenue data
- Data transformation procedures for insightful reporting
- Revenue reporting based on film categories

## Installation Instructions
1. Install PostgreSQL and pgAdmin 4.
2. Execute the provided SQL scripts to set up and populate the database.

## Usage Instructions
- Use the SQL scripts to generate revenue reports.
- Use the external pgAgent application to schedule the job of automating the stored procedure to run monthly, on the last day of every month. For the justification of why the data should be refreshed at this frequency, see Report Refresh Cycle and Strategic Timing.

## About

### Data
Source: [PostgreSQL's Sample DVD Rental Database](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/)

![Data Used](./images/dvd-rental-data-used.jpg)
- **Variables**: Names of variables.
- **Report Table**: Which report table (detailed or summary) the variables belong to.
- **Database Table**: Which table from the dvdrental database the variable originates from.
- **Datatype**: Type of variable.
- **Description**: Brief description of the variable.

### Tables from dvdrental Database
The tables used from the dvdrental database that provide the necessary data for the detailed and summary report tables are:
1.	`category`
2.	`film_category`
3.	`film`
4.	`inventory`
5.	`rental`
6.	`payment`

### Fields
The `name` field from the `category` table and the `amount` field from the `payment` table are integrated into both the detailed and summary report tables. This ensures consistent data representation across both reporting structures. Conversely, specific fields like `category_id` from `film_category`, `film_id` from `film`, `inventory_id` from `inventory`, and `rental_id` from `rental` are exclusively designated for the detailed report table. This selective allocation is designed to enrich the detailed reports with more granular data, enhancing the depth and specificity of the analysis.

In the detailed report table, the `amount` field undergoes a two-step transformation process for integration into the summary table. Firstly, it is aggregated using the `SUM()` function, enabling the use of the `GROUP BY` clause to categorize total revenue by film category. This aggregation not only provides vital revenue insights but also significantly reduces the detailed table's size, enhancing its readability. Secondly, the `amount` field is converted into a string format to display values as percentages. PostgreSQL lacks a native percent data type, hence this transformation facilitates a more intuitive display. Displaying the percentage symbol alongside the numerical value adheres to conventional data presentation standards, reducing cognitive load during analysis. This approach is particularly beneficial in monthly review scenarios, which are typically time-sensitive and task-intensive. The transformation ensures clarity and prevents confusion, especially when presented adjacent to aggregated numeric columns.

### Business Uses
#### Detailed Report Uses:
1. **Selective Data Representation**: The detailed report strategically aligns film categories with films that have generated revenue. This filters out non-revenue-generating inventory, streamlining the report for efficiency and focus.
2. **Customer and Staff Insight**: By grouping data by `rental_id`, the report reveals patterns in customer and staff interactions with different film categories. Recognizing these trends enables targeted inventory adjustments, potentially enhancing sales and revenue.

#### Summary Report Uses:
1. **Immediate Analytical Value**: The summary report offers a swift assessment of each category's contribution to total revenue. It enables quick goal-setting and comparative analysis with previous reports, facilitating immediate strategic decisions.
2. **Long-Term Strategic Planning**: Over time, the report aids in identifying patterns between implemented strategies, actions taken, and revenue changes. This long-term perspective allows for more controlled and goal-oriented management of category-specific revenue, aligning with overarching business objectives.

### Report Refresh Cycle and Strategic Timing
The monthly refresh cycle for the report is strategically chosen to balance the need for timely data analysis and the impact of variable external factors on DVD rental sales. Daily and weekly measurements, while informative, may not adequately capture trends due to fluctuations caused by events like holidays or unexpected occurrences such as a pandemic. Seasonal (quarterly) analysis, though potentially useful, poses challenges in a geographically diverse market where seasonal impacts vary significantly.

A monthly refresh aligns with the dynamic nature of the business, allowing for the assessment of diverse external conditions while providing a sufficiently granular view to observe trends and the effectiveness of business strategies. This cadence ensures the data remains relevant and actionable for stakeholders, facilitating informed decision-making and trend analysis.

## Contributing
Contributions to this project are welcome. Please fork the repository and submit a pull request for review.

## License
This project is open-sourced under the [MIT License](LICENSE).