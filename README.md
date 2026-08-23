# 📊 Customer Cohort Retention & SLA Logistics Pipeline

An end-to-end data analytics project focused on measuring customer retention dynamics, cohort churn patterns, and fulfillment SLA logistics performance. The pipeline handles raw transactional data processing in MS SQL Server, data model structuring in Power Pivot, DAX logic implementation, and visual dashboard reporting in Power BI.

---

## 🛠️ Tech Stack & Workflow

* **Database & Querying:** MS SQL Server (Pivot transformations, matrix aggregations, timeline tracking)
* **Data Modeling:** Microsoft Excel / Power Pivot (Star schema modeling, relationships)
* **BI & Analytics:** Power BI Desktop (DAX measures, cohort matrices, visual reporting)

---

## 🔑 Technical Execution

### 1. MS SQL Server Data Processing & Matrix Formulation
* Extracted and cleaned raw order logs across transactional tables.
* Engineered cohort matrix logic directly in SQL using aggregate functions and conditional aggregation (`CASE WHEN` / `PIVOT`) to calculate user retention retention relative to initial order month (`Month 0` through `Month 8+`).
* Computed order-to-shipment SLA durations (`ship_date` minus `order_date`) to measure carrier performance.

### 2. Data Modeling & Star Schema (Power Pivot)
* Built relational star schema models linking fact tables (`Fact_Cohort_Retention`, `Fact_SLA_Logistics`) with key primary/foreign keys (`customer_id`, `sales_order_id`).
* Standardized date parameters across tables to allow cross-filtering across time periods.

### 3. DAX Formulas & Calculation Logic
* **Cohort Retention Matrix:** Constructed dynamic matrix visuals displaying customer volume decay across retention periods.
* **Fulfillment SLA Buckets:** Created custom `SWITCH` conditional logic to bin shipping lead times into operational categories (*Same Day*, *Fast*, *Standard*, *Delayed*, *Unknown*).
* **Summary Metrics:** Configured measure aggregations for Total Revenue, Order Volume, Active Customer Counts, and Average Delivery Days.

### 4. Power BI Reporting & Visuals
* **Cohort Matrix Table:** Heatmap matrix displaying retention volume from initial acquisition month through subsequent active months.
* **Fulfillment Speed Funnel:** Vertical breakdown displaying volume distribution across delivery speed categories.
* **KPI Summary Cards:** Metric cards monitoring top-line revenue, active user counts, total orders, and mean shipping SLAs.
* **Status Distribution:** Donut and horizontal bar charts mapping delivery outcomes (*Delivered*, *In Transit*, *Lost*, *Delayed*, *NULL*).
* **Cross-Filtering & Slicers:** Date sliders (`Purchase Month`) and delivery status filters for dynamic drill-downs.

---

## 📌 Key Findings

* **Retention Decay:** Cohort retention drops sharply after Month 0, stabilizing into baseline repeat usage patterns by Month 2.
* **Fulfillment Distribution:** The majority of orders fall within standard (2-day) and fast (1-day) delivery windows, maintaining an overall average delivery speed of 1.39 days.

```
