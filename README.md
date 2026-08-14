# Healthcare-analytics-sql-powerbi
Healthcare Process Optimization & Analytics Dashboard

SQL + Power BI project analyzing patient admissions, demographics, and billing trends across a synthetic hospital dataset — built end-to-end on Google BigQuery and Power BI.

Objective

Simulate a real-world healthcare analytics workflow: take raw, unvalidated patient admission records, clean and structure them into an analysis-ready dataset, and surface actionable KPIs and trends for stakeholder reporting — patient demographics, hospital-level admission patterns, and billing behavior.

Data Source

Dataset: Healthcare Dataset (55,500 records) — Kaggle
Note: This is a synthetic dataset generated for analytics practice, not real patient/hospital records. Fields include patient demographics, admission/discharge dates, hospital, doctor, admission type, billing amount, and test results.

Tools Used

Google BigQuery — data storage, cleaning, and SQL analysis
SQL — data validation, transformation, and aggregation queries
Power BI — dashboard and visualization layer

What I Did

Data cleaning & validation: Loaded 55,500 raw records into BigQuery and built a cleaned view that removes null dates, invalid date logic (discharge before admission), impossible ages, zero/negative billing values, and duplicate admission records.
Demographic analysis: Queried patient distribution and average billing across age groups and gender.
Hospital & admission-type trends: Analyzed admission volume, average length of stay, and average billing across 4 hospitals and 4 admission types (Emergency, Elective, Urgent, Routine).
KPI summary: Calculated headline operational metrics for stakeholder reporting.
Dashboard: Connected BigQuery to Power BI and built a KPI + visual summary dashboard.

See queries.sql for the full SQL.

Key Findings

Data quality: Cleaning removed 9.9% of raw records (55,500 → 50,000) due to invalid dates, out-of-range ages, and duplicate entries.
Total admissions analyzed: 50,000
Average length of stay: 16.9 days
Average billing per patient: $20,862.25
Total billing volume: $1.04 billion
Abnormal test results: 50% of all patients
Billing scales strongly with age: average billing rises roughly 10x from under-18 patients ($3,450) to 75+ patients ($41,300), with no meaningful gender gap at any age band.
Admission type drives cost and stay more than hospital does: Emergency admissions have the shortest average stay (15 days) and lowest average billing ($17.6K–18.5K); Routine admissions have the longest stay (19–20 days). All 4 hospitals showed consistent patterns, with no single outlier hospital.

Dashboard

Tableau Public Image

![Healthcare Analytics Dashboard](/Dashboard 1.png) 

Power BI  Image

<img width="673" height="334" alt="image" src="https://github.com/user-attachments/assets/27758f93-8ea8-4096-9870-a85702e45766" />


Both dashboards present the same underlying analysis — built separately to demonstrate proficiency across BI tools.

Next Steps

Extend the model with a time-series view (admissions/billing trend over months) if the dataset is expanded with a wider date range.
Add a filter/slicer panel (by hospital, admission type, date range) to make the dashboard interactive for different stakeholder questions.
Validate findings against a real (anonymized) healthcare dataset if access becomes available, to compare synthetic vs. real-world patterns

