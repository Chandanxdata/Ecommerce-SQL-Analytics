# Ecommerce SQL Analytics Project

## Project Overview
This project demonstrates end-to-end **SQL-based data analysis** on an e-commerce dataset.  
The goal is to showcase skills in **database design, relational modeling, SQL querying, and business analysis**, aligned with real data analytics job requirements.

## Tools & Technologies
- MySQL (Database & SQL analysis)
- MySQL Workbench
- GitHub (Project documentation)
- Power BI (Visualization – optional extension)

## Database Schema
The project uses a **normalized relational schema** with the following tables:

- customers – customer details and city
- products – product category and price
- orders – order-level information
- order_items – order to product mapping with quantity
- payments – payment method, status, and revenue

Foreign key relationships are enforced to ensure data integrity and enable join-based analysis.

Schema creation queries are available in **schema.sql**.

## Dataset
 e-commerce dataset
- ~25,000 orders
- Realistic distribution of:
  - customers across multiple cities
  - product categories and prices
  - payment methods and order statuses


## SQL Analysis
All analysis queries are available in **analysis_queries.sql** and include:

- Revenue analysis by city and category
- Customer behavior (repeat customers, top spenders)
- Product performance analysis
- Time-based trends (monthly revenue)
- Payment method performance
- Average order value (AOV)
- Advanced SQL:
  - JOINs
  - GROUP BY & HAVING
  - Subqueries
  - Window functions (RANK)

Each query includes clear headers explaining the **business question being answered**.

## Key Business Insights
- Certain cities consistently generate higher revenue.
- A small group of repeat customers contributes a large share of total sales.
- Electronics and Fashion categories are major revenue drivers.
- Digital payment methods dominate completed transactions.
- Monthly revenue trends reveal seasonality patterns.

## How to Use This Project
1. Create the database using schema.sql
2. Load data into tables
3. Run queries from `analysis_queries.sql
4.  Connect database to Power BI for visualization

## What This Project Demonstrates
- Strong understanding of relational databases
- Ability to translate business questions into SQL queries
- Experience with real analytics workflows
- 
## Author
**Chandan**

Aspiring Data Analyst | SQL | Power BI | Data Analytics

