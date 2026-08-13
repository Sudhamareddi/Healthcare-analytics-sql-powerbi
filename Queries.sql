##Cleaning the Dataset
CREATE OR REPLACE VIEW healthcare-sql-analysis.Primary.clean_admissions AS
SELECT
  Name,
  Age,
  Gender,
  `Blood Type` AS blood_type,
  `Medical Condition` AS medical_condition,
  `Date of Admission` AS admission_date,
  `Discharge Date` AS discharge_date,
  Doctor,
  Hospital,
  `Insurance Provider` AS insurance_provider,
  `Billing Amount` AS billing_amount,
  `Room Number` AS room_number,
  `Admission Type` AS admission_type,
  Medication,
  `Test Results` AS test_results,
  DATE_DIFF(`Discharge Date`, `Date of Admission`, DAY) AS length_of_stay_days
FROM healthcare-sql-analysis.Primary.Records
WHERE
  `Date of Admission` IS NOT NULL
  AND `Discharge Date` IS NOT NULL
  AND `Discharge Date` >= `Date of Admission`   -- removes impossible date logic
  AND Age BETWEEN 0 AND 120                      -- removes bad age entries
  AND `Billing Amount` > 0                        -- removes zero/negative billing errors
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY Name, `Date of Admission`, Doctor
  ORDER BY `Date of Admission`
) = 1;   -- dedupes exact repeat admission records

##Hospital / admission-type trends
SELECT
  (SELECT COUNT(*) FROM `healthcare-sql-analysis.Primary.Records`) AS raw_rows,
  (SELECT COUNT(*) FROM `healthcare-sql-analysis.Primary.clean_admissions`) AS clean_rows;


  Hospital,
  admission_type,
  COUNT(*) AS admissions,
  ROUND(AVG(length_of_stay_days), 1) AS avg_length_of_stay,
  ROUND(AVG(billing_amount), 2) AS avg_billing
FROM `healthcare-sql-analysis.Primary.clean_admissions`
GROUP BY Hospital, admission_type
ORDER BY admissions DESC
LIMIT 20;

##Demographics breakdown (age groups, gender, blood type distribution)
SELECT
  CASE
    WHEN Age < 18 THEN 'Under 18'
    WHEN Age BETWEEN 18 AND 35 THEN '18-35'
    WHEN Age BETWEEN 36 AND 55 THEN '36-55'
    WHEN Age BETWEEN 56 AND 75 THEN '56-75'
    ELSE '75+'
  END AS age_group,
  Gender,
  COUNT(*) AS patient_count,
  ROUND(AVG(billing_amount), 2) AS avg_billing
FROM `healthcare-sql-analysis.Primary.clean_admissions`
GROUP BY age_group, Gender
ORDER BY age_group, Gender;

##Core KPI summary
SELECT
  COUNT(*) AS total_admissions,
  ROUND(AVG(length_of_stay_days), 1) AS avg_length_of_stay,
  ROUND(AVG(billing_amount), 2) AS avg_billing_per_patient,
  ROUND(SUM(billing_amount), 0) AS total_billing,
  ROUND(COUNTIF(test_results = 'Abnormal') / COUNT(*) * 100, 1) AS pct_abnormal_results
FROM `healthcare-sql-analysis.Primary.clean_admissions`;
  
