Supply Chain Risk, Operations & Performance Analytics

📌 Project Overview

This project analyzes 180K+ supply-chain transaction records to evaluate sales performance, profitability, delivery efficiency, operational risk, and financial exposure.

The analysis follows an end-to-end workflow using Python, SQL Server, and Power BI, transforming raw supply-chain data into actionable business insights.

🎯 Business Objectives

Analyze overall sales and profitability performance.

Identify profitable and low-margin products and categories.

Evaluate delivery performance and shipping delays.

Identify orders and sales exposed to delivery risk.

Analyze operational performance across markets, regions, and shipping modes.

Identify loss-making products and categories.

Evaluate the impact of discount levels on profitability.

Highlight high-sales, low-margin products requiring review.

Develop a category-level supply-chain risk assessment.


🛠️ Tools & Technologies

Python — Data Cleaning & Exploratory Data Analysis

Pandas — Data Manipulation

Matplotlib — Data Visualization

SQL Server — Data Storage & Business Analysis

Power BI — Interactive Dashboard & Data Visualization

DAX — KPI and Risk Calculations


🔄 Project Workflow

Raw Supply Chain Dataset
        ↓
Python Data Cleaning
        ↓
Exploratory Data Analysis
        ↓
SQL Server
        ↓
Advanced SQL Analysis
        ↓
Power BI Data Modeling & DAX
        ↓
Interactive Supply Chain Dashboards
        ↓
Business Insights & Risk Assessment

🧹 Data Cleaning & Preparation

Python was used to prepare the dataset for analysis.

Key activities included:

Removed irrelevant and redundant columns.

Removed personally identifiable customer information.

Standardized column names.

Converted date fields into appropriate date formats.

Checked for duplicate records.

Identified missing values.

Validated numerical fields and data ranges.

Compared actual and scheduled shipping days.

Performed consistency checks on transaction-level calculations.

Exported the cleaned dataset for SQL Server analysis.


Data Quality Results

180K+ records analyzed.

0 duplicate rows identified.

Only 3 missing values were identified in Customer Zipcode.

Negative profit values were retained because they represent genuine loss-making transactions.


📊 Exploratory Data Analysis

Initial analysis in Python focused on understanding:

Sales and profit distribution.

Sales trends over time.

Sales by market and category.

Customer-segment performance.

Shipping performance.

Delivery-risk patterns.

Order-status distribution.

Product-level sales and profitability.

Actual vs scheduled shipping duration.


Key EDA Findings

Total sales were approximately $36.8M.

Total profit was approximately $4.0M.

Europe generated the highest sales at approximately $10.87M.

Fishing generated the highest category sales at approximately $6.9M.

Consumer was the largest customer segment with approximately $17.2M in sales and $1.87M profit.

January recorded the highest monthly sales and profit, while December recorded the lowest.

Average actual shipping time was 2.93 days, compared with 3.50 scheduled days.


🗄️ SQL Server Analysis

The cleaned dataset was imported into SQL Server for deeper business analysis.

SQL techniques used included:

GROUP BY

HAVING

CASE

Conditional aggregation

COUNT(DISTINCT)

CTE

ROW_NUMBER()

LAG()

Ranking

Profit-margin calculations

Month-over-month analysis


Key SQL Analyses

Category profitability analysis.

Market delivery-risk analysis.

Customer-segment profitability.

Discount-band profitability.

Top products by profit.

Loss-making products and categories.

Regional profitability.

Delivery performance by region.

Actual vs scheduled delivery gap.

Order-status profitability.

Top products within each category.

Monthly sales and MoM growth analysis.


📈 Power BI Dashboard

The Power BI report contains four analytical pages.

1. Executive Overview

Provides a high-level view of supply-chain performance.

KPIs:

Total Sales

Total Profit

Total Orders

Total Customers

Total Units Sold


Analysis includes:

Monthly Sales & Profit Trend

Sales by Market

Top 10 Categories by Sales

Market Performance

Sales by Customer Segment

Top 10 Order Regions by Sales & Profit


2. Profitability & Product Intelligence

Focuses on profitability, pricing, discounts, and product performance.

KPIs:

Total Sales

Total Orders

Profit Margin %

Average Sales per Order

Average Discount


Analysis includes:

Discount Impact on Profitability

Profitability by Customer Segment

High-Sales, Low-Margin Products


3. Delivery & Logistics Intelligence

Evaluates logistics and delivery performance.

KPIs:

Total Orders

Late Delivery %

Average Delay Days

Average Actual Shipping Days

Average Scheduled Shipping Days


Analysis includes:

Actual vs Scheduled Shipping Days Trend

Late Delivery % by Order Region

Late Delivery % by Shipping Mode

Shipping Mode Performance

Delivery Status Distribution


4. Supply Chain Risk & Operations

Focuses on operational risk and financial exposure.

KPIs:

Late Delivery %

Average Delay Days

Orders at Risk

Revenue at Risk

Loss-Making Orders

Total Loss Amount


Analysis includes:

Revenue at Risk by Market

Revenue at Risk by Shipping Mode

Orders at Risk by Order Status

Order Risk & Revenue Exposure by Status

Loss-Making Orders & Loss Amount by Category

Average Delay by Shipping Mode

Category Supply Chain Risk Matrix

Key Risk Insights


🔍 Key Business Findings

Delivery Risk

54.83% of records carried a late-delivery-risk flag.

Approximately 36K orders were identified as being at delivery risk.

Approximately $20.13M in sales were associated with late-delivery-risk records.

First Class had the highest delivery-risk rate at 95.32%.

Second Class recorded the highest average delay at 1.99 days.

Overall average delay was 0.57 days.


Profitability

Overall profit margin was approximately 10.78%.

Cleats recorded the highest category profit margin at 11.16%.

Pacific Asia had the lowest market profit margin at 10.16%.

USCA recorded the highest market profit margin at 11.14%.


Product & Category Risk

5 high-sales, low-margin products were identified for further review.

Shop by Sport showed a 9.91% profit margin, 55.15% delivery risk, and approximately $721K sales exposure, making it a high-priority category for investigation.

Fishing generated the highest category sales at approximately $6.9M.

Fishing also had significant loss exposure and required profitability monitoring.


Discount Analysis

The 0–10% discount band generated the highest total profit at approximately $1.88M.

No-discount orders achieved the highest profit margin at 13.09%.

This indicates that higher total profit does not necessarily mean higher profitability efficiency.


Financial Risk

Approximately 25K orders were identified as loss-making.

Total loss amount was approximately $3.88M.

LATAM had the highest revenue-at-risk exposure at approximately $5.9M.

Europe followed with approximately $5.2M in revenue-at-risk exposure.


💡 Business Recommendations

Review shipping-mode performance, particularly areas with high delivery-risk exposure.

Investigate high-sales products with comparatively low profit margins.

Review categories combining high delivery risk with weak profitability.

Monitor discount levels to balance sales volume with profitability.

Prioritize markets and operational areas with high financial exposure to delivery risk.

Investigate loss-making categories to identify opportunities for pricing, discount, or operational improvements.


📌 Important Metric Definitions

Orders at Risk
Unique orders containing records flagged with Late_delivery_risk = 1.

Revenue at Risk
Sales associated with records where Late_delivery_risk = 1. This represents sales exposure associated with delivery risk and does not mean confirmed revenue loss.

Loss-Making Orders
Unique orders containing at least one record with negative Order Profit Per Order.

Total Loss Amount
Absolute value of negative Order Profit Per Order, representing profit loss rather than revenue loss.

🎯 Project Outcome

The project transformed raw supply-chain data into a multi-layer analytical solution covering:

Sales → Profitability → Products → Logistics → Delivery Risk → Financial Exposure → Operational Risk

The final Power BI dashboards provide a management-oriented view of supply-chain performance and help identify high-risk operational areas, profitability issues, and financially exposed segments.

👤 Skills Demonstrated

Python | Pandas | Matplotlib | SQL Server | Advanced SQL | Power BI | DAX | Data Cleaning | Exploratory Data Analysis | Data Modeling | Business Intelligence | Supply Chain Analytics | Risk Analysis | Profitability Analysis
