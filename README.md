
# 🎵 Apple iTunes Music Intelligence Dashboard

<p align="center">
  <strong>SQL-Powered Music Store Analytics & Business Intelligence</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL-MySQL%20Workbench-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="SQL and MySQL">
  <img src="https://img.shields.io/badge/Domain-Music%20Analytics-8A2BE2?style=for-the-badge" alt="Music Analytics">
  <img src="https://img.shields.io/badge/Platform-GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
</p>

<p align="center">
  An end-to-end SQL analytics project exploring music sales, customer behavior, genre performance, artist trends, and business opportunities using the Apple iTunes music store dataset.
</p>

---

## 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Dashboard Gallery](#-dashboard-gallery)
- [Project Objectives](#-project-objectives)
- [Technology Stack](#-technology-stack)
- [Dataset Overview](#-dataset-overview)
- [Dashboard Modules](#-dashboard-modules)
- [Business Questions](#-business-questions)
- [SQL Concepts Applied](#-sql-concepts-applied)
- [Repository Structure](#-repository-structure)
- [Getting Started](#-getting-started)
- [Business Value](#-business-value)
- [Limitations](#-limitations)
- [Future Enhancements](#-future-enhancements)
- [Author](#-author)

---

## 📌 Project Overview

The **Apple iTunes Music Intelligence Dashboard** is a data analytics and business intelligence project designed to transform music store transaction data into meaningful business insights.

Using SQL for data exploration, aggregation, and relational analysis, the project investigates sales performance, customer purchasing behavior, genre popularity, artist performance, geographic distribution, employee-related metrics, and operational patterns.

The project combines structured query development with dashboard-based reporting to make analytical findings easier to understand and communicate.

### 🎯 Business Problem

Music store transaction data contains valuable information about customers, invoices, tracks, artists, genres, and sales. However, raw tables alone do not immediately reveal which products perform well, how customers purchase music, or where potential business opportunities exist.

This project addresses that challenge by organizing data into meaningful analytical categories and presenting insights through an interactive dashboard.

### 💡 Project Approach

**Raw Data → Data Preparation → SQL Analysis → Dashboard Visualization → Business Insights**

---

## 📸 Dashboard Gallery

The following screenshots showcase the key pages and data model of the Apple iTunes Music Intelligence Dashboard.

> Screenshots are stored in the `dashboardScreenshot/` directory. Keep the filenames consistent with the image links below.

### 🏠 Home Page

The landing page introduces the dashboard and provides navigation to the analytical modules.

![Home Page](DashboardScreenshots\HomePage.jpg)

### 📊 Executive Overview

A high-level view of business performance and key analytical indicators.

![Executive Overview Page](DashboardScreenshots\ExecutiveOverviewPaage.jpg)

### 🎵 Music Revenue Intelligence

Explores revenue distribution and music sales performance across relevant dimensions.

![Music Revenue Intelligence Page](DashboardScreenshots\MusicRevenueIntelligencePage.jpg)

### 👥 Customer Intelligence

Examines customer spending, purchase behavior, and customer-level insights.

![Customer Intelligence Page](DashboardScreenshots\CustomerIntelligencePage.jpg)

### 🌍 Geographic & Employee Insights

Presents geographic distribution and employee-related analytical views.

![Geographic and Employee Insights Page](DashboardScreenshots\Geographic&EmployeeInsightsPage.jpg)

### 🔗 Relationship View

Shows relationships between the underlying data tables, where applicable.

![Relationship View](DashboardScreenshots\Relationship.png)

### 🤖 Data Model View

Displays the model structure used to support data analysis and dashboard reporting.

![Data Model View](DashboardScreenshots\ModelView.jpg)

---

## 🎯 Project Objectives

- Analyze overall sales and revenue performance.
- Identify top-performing tracks, artists, albums, and genres.
- Understand customer purchasing patterns and spending behavior.
- Explore repeat purchases and customer retention opportunities.
- Investigate geographic sales distribution.
- Examine employee-related metrics and customer assignments.
- Identify commonly purchased track combinations.
- Explore track pricing and media-type patterns.
- Present findings through clear dashboard visualizations.
- Develop data-driven business recommendations.

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| SQL | Data querying, aggregation, and analytical investigation |
| MySQL Workbench | SQL development and query execution |
| CSV | Data storage and import |
| Dashboarding Tool | Interactive visual reporting |
| Git & GitHub | Version control and project documentation |

**Note:** The dashboard screenshots appear to show a Power BI-style interface. If Power BI was used to build the dashboard, specify **Microsoft Power BI** in the technology stack and include the `.pbix` file if it is suitable for sharing.

---

## 📂 Dataset Overview

The project uses a relational music store dataset containing information about customers, invoices, tracks, artists, genres, playlists, and employees.

The following tables represent a common iTunes database schema. Actual table names and available columns should be verified against the imported files.

| Table | Description |
|---|---|
| `customer` | Customer information and geographic details |
| `invoice` | Purchase transactions and invoice details |
| `invoiceline` | Individual tracks included in invoices |
| `track` | Track metadata, duration, and unit price |
| `album` | Album details |
| `artist` | Artist information |
| `genre` | Music genre classifications |
| `mediatype` | Media format categories |
| `playlist` | Playlist information |
| `playlisttrack` | Playlist-to-track relationships |
| `employee` | Employee information and reporting structure |

### Data Preparation

The analysis workflow may include:

- Importing CSV files into the database or dashboarding environment.
- Reviewing column names and data types.
- Checking missing values and duplicate records.
- Validating identifiers and table relationships.
- Verifying joins and aggregate calculations.
- Ensuring that revenue calculations use the appropriate transaction fields.

---

## 📊 Dashboard Modules

### 1. Home Page
Provides an entry point to the dashboard and its major analytical sections.

### 2. Executive Overview
Summarizes high-level business performance using key metrics and visualizations.

### 3. Music Revenue Intelligence
Analyzes music sales and revenue patterns across available categories.

### 4. Customer Intelligence
Explores customer spending, invoice frequency, and purchasing behavior.

### 5. Geographic & Employee Insights
Examines customer locations, geographic patterns, and employee-related metrics.

### 6. Relationship View
Helps users understand how relevant tables and entities relate to one another.

### 7. Data Model View
Provides a structural overview of the model used for the analytical solution.

---

## 💼 Business Questions

The project investigates questions such as:

1. Which countries contribute the most to recorded sales?
2. Who are the highest-spending customers?
3. Which music genres generate the highest revenue?
4. Which artists have the most tracks within a particular genre?
5. Which tracks and albums perform well commercially?
6. How frequently do customers make purchases?
7. What is the average invoice value?
8. Which customers purchase tracks across multiple genres?
9. Which track combinations are commonly purchased together?
10. How do track prices relate to sales performance?
11. How does customer spending vary across employee assignments?
12. What opportunities exist to improve customer engagement and retention?

The answers should be supported by executed queries and validated results.

---

## 🧠 SQL Concepts Applied

The project can demonstrate the following SQL techniques, depending on the queries implemented:

- `SELECT`, `WHERE`, `ORDER BY`
- Aggregate functions: `SUM()`, `COUNT()`, `AVG()`
- `GROUP BY` and `HAVING`
- Joins and relational data analysis
- Subqueries and correlated subqueries
- Common Table Expressions (CTEs)
- Window functions and ranking
- Date-based analysis
- Conditional logic using `CASE`
- Self-joins and purchase-combination analysis

These techniques support data extraction, summarization, comparisons, and the investigation of business questions.

---

## 📁 Repository Structure

```text
apple-itunes-music-intelligence-dashboard/
│
├── dashboardScreenshot/
│   ├── Customer Intelligence Page.png
│   ├── Executive Overview Page.png
│   ├── Geographic & Employee Insights Page.png
│   ├── Home Page.png
│   ├── Model View.png
│   ├── Music Revenue Intelligence Page.png
│   └── Relationship.png
│
├── data/
│   ├── customer.csv
│   ├── employee.csv
│   ├── genre.csv
│   ├── invoice.csv
│   ├── invoiceline.csv
│   ├── mediatype.csv
│   ├── playlist.csv
│   ├── playlisttrack.csv
│   └── track.csv
│
├── SQL/
│   ├── 01_sales_performance.sql
│   ├── 02_customer_analytics.sql
│   ├── 03_artist_genre_analysis.sql
│   ├── 04_geographic_analysis.sql
│   ├── 05_employee_performance.sql
│   ├── 06_customer_retention.sql
│   └── 07_operational_optimization.sql
│
├── reports/
│   └── insights_report.pdf
│
├── README.md
└── .gitignore
```

> This is an illustrative structure. Update it to match the files actually present in your repository. Include `album.csv`, a dashboard file, or other assets only when they exist.

---

## 🚀 Getting Started

### Prerequisites

- MySQL Workbench or another compatible SQL environment.
- The project CSV files.
- A dashboarding application if you want to explore the interactive report.

### Installation and Usage

**Step 1 — Clone the repository**

```bash
git clone https://github.com/YOUR_USERNAME/apple-itunes-music-intelligence-dashboard.git
```

**Step 2 — Navigate to the project directory**

```bash
cd apple-itunes-music-intelligence-dashboard
```

**Step 3 — Import the dataset**

Import the available CSV files into your SQL database or the relevant data preparation environment.

**Step 4 — Validate the data**

Check table structures, data types, key columns, and relationships before running analytical queries.

**Step 5 — Execute the SQL scripts**

Open the scripts in the `SQL/` directory and execute the queries against the configured database.

**Step 6 — Explore the dashboard**

Open the dashboard file in its supported application, if included in the repository.

**Step 7 — Review the findings**

Use the query outputs and dashboard visualizations to document verified insights and business recommendations.

---

## 📈 Business Value

The analytical workflow can support:

- Identification of high-value customers and revenue-generating products.
- Better understanding of customer purchasing preferences.
- Comparison of genre, artist, and track performance.
- Exploration of repeat-purchase and retention patterns.
- Geographic sales analysis.
- Investigation of product pricing and purchasing combinations.
- Evidence-based business recommendations.

These are potential applications of the analysis. Specific findings and their business impact should be documented using verified results from the project.

---

## ⚠️ Limitations

- The quality of conclusions depends on the completeness and consistency of the dataset.
- Transaction data does not capture every aspect of customer preferences.
- Historical purchasing behavior may not predict future behavior.
- Correlation does not establish causation.
- Geographic and employee comparisons require appropriate context.
- Revenue and performance metrics depend on correct joins and aggregation logic.
- Findings are limited to the available dataset and observation period.

---

## 🚀 Future Enhancements

- Add additional validated KPIs and dashboard filters.
- Expand customer segmentation and retention analysis.
- Automate data quality checks.
- Create reusable SQL views for recurring analysis.
- Add a documented data dictionary.
- Include selected query outputs and evidence-based findings.
- Develop additional visualizations where they improve analytical clarity.

---

## 👨‍💻 Author

**Ayush Dash**

Data Analytics | SQL | Business Intelligence | Data Visualization

---

## ⭐ Project Highlights

- Relational music store data analysis.
- SQL-based business investigation.
- Sales and customer intelligence.
- Interactive dashboard reporting.
- Business-focused analytical documentation.

If you find this project useful, explore the SQL scripts, dashboard screenshots, and supporting documentation included in the repository.

---

<p align="center">
  <strong>Turning Music Store Data into Meaningful Business Insights 🎵</strong>
</p>
