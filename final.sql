Drop table if exists load_data;
CREATE TABLE loan_data (
    loan_id INT PRIMARY KEY,
    issue_date DATE,
    term_months INT,
    loan_amnt DECIMAL(10,2),
    interest_rate DECIMAL(5,2),
    grade CHAR(1),
    sub_grade VARCHAR(3),
    emp_length_years INT,
    annual_income DECIMAL(12,2),
    dti DECIMAL(5,2),
    state CHAR(2),
    home_ownership VARCHAR(20),
    purpose VARCHAR(50),
    application_type VARCHAR(20),
    verification_status VARCHAR(20),
    delinq_2yrs INT,
    inq_last_6m INT,
    open_acc INT,
    revol_util DECIMAL(5,2),
    revol_bal DECIMAL(12,2),
    total_acc INT,
    earliest_credit_line_year INT,
    fico_low INT,
    fico_high INT,
    pub_rec INT,
    mort_acc INT,
    pub_rec_bankruptcies INT,
    default_flag INT,
    default_date DATE,
    last_pymnt_date DATE,
    recoveries DECIMAL(10,2),
    collection_recovery_fee DECIMAL(10,2)
);

-- Total portfolio summary
SELECT 
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS total_defaults,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount
FROM loan_data;



-- Default rate by grade
SELECT 
    grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
GROUP BY grade
ORDER BY default_rate_pct DESC;



-- rate for long term months
SELECT 
    term_months,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
GROUP BY term_months
ORDER BY default_rate_pct DESC;



-- Default rate by grade and term
SELECT 
    grade,
    term_months,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
GROUP BY grade, term_months
ORDER BY grade, term_months;



-- Top 10 stated by default rate
SELECT 
    state,
    COUNT(*) AS total_loans,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
GROUP BY state
HAVING COUNT(*) > 50
ORDER BY default_rate_pct DESC
LIMIT 10;



-- Impact of DTI on default rate
SELECT 
    CASE 
        WHEN dti < 15 THEN '<15'
        WHEN dti BETWEEN 15 AND 25 THEN '15-25'
        WHEN dti BETWEEN 25 AND 35 THEN '25-35'
        ELSE '>35'
    END AS dti_range,
    COUNT(*) AS total_loans,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
GROUP BY dti_range
ORDER BY default_rate_pct DESC;



-- Total recovery rate
SELECT 
    ROUND(100.0 * SUM(recoveries) / SUM(loan_amnt), 2) AS recovery_rate_pct
FROM loan_data
WHERE default_flag = 1;



-- Default rate by issue year
SELECT 
    EXTRACT(YEAR FROM issue_date) AS issue_year,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
GROUP BY issue_year
ORDER BY issue_year;



-- Average interest rate by purpose
SELECT 
    purpose,
    verification_status,
    COUNT(*) AS total_loans,
    ROUND(AVG(interest_rate), 2) AS avg_interest_rate,
    ROUND(100.0 * SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM loan_data
GROUP BY purpose, verification_status
ORDER BY default_rate_pct DESC;



-- Recovery amount by grade for defaults
SELECT 
    grade,
    COUNT(*) AS total_defaults,
    ROUND(AVG(recoveries), 2) AS avg_recoveries,
    ROUND(AVG(collection_recovery_fee), 2) AS avg_collection_fee
FROM loan_data
WHERE default_flag = 1
GROUP BY grade
ORDER BY grade;













