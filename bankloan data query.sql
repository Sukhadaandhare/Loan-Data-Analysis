use financial_loandata;
describe bankloan;
alter table bankloan modify column Company_name varchar(70) NULL;
-- 1) Total Loan appliacations
select count(id) as 'total applications' from bankloan;
-- MTD loan application
select count(id) as 'total application month to date ' from bankloan where month(Loan_issuedate)=12;
-- PMTD per month lone application 1 to 11 
select count(id) as 'total application per month' from bankloan where month(Loan_issuedate)>=1 and month(Loan_issuedate)<12;
-- 2) Total Funded Amount 
select sum(loan_amount) as  ' Total funded ammount 'from bankloan;
-- Total funded ammount MTD 
select sum(loan_amount) as 'total funded amount of 12th month' from bankloan where month(Loan_issuedate)=12;
-- total funded aamount of MOM Month over Month 
select sum(loan_amount) as 'total funded amount of 1 to 11 month' from bankloan where month(Loan_issuedate)>=1 and month(Loan_issuedate)<12;
-- 3) Total aamount recieved from customer 
select sum(total_payment) as 'Total ammount recieve from customer' from bankloan;
-- total recieved ammount month to date MTD 
select sum(total_payment) as 'total recieved amount of 12th month' from bankloan where month(Loan_issuedate)=12;
-- total recieved ammount month over month MOM
select sum(total_payment) as 'total revieved amount of 1 to 11 month' from bankloan where month(Loan_issuedate)>=1 and month(Loan_issuedate)<12;
-- Avg of interest rate 
select avg(interest_rate)*100 as 'average amount of  month' from bankloan;
-- Average rate of month to date 
select avg(interest_rate)*100 as 'average amount of  month to date ' from bankloan where month(Loan_issuedate)=12;
-- Average rate of mont over month 
select avg(interest_rate)*100 as 'Average ammount of month over month' from bankloan where month (Loan_issuedate)>=1 and month(Loan_issuedate)<12;
-- Average value of Dti 
select avg(dti)*100 as ' avg DTI' from bankloan;
-- Average value of DTI od MTD
select avg(dti)*100 as 'avg DTI MTD' from bankloan where month(Loan_issuedate)=12;
-- Average rate of dti MOM 
select avg(dti)*100 'avg DTI MOM' from bankloan where month(loan_issuedate)>=1 and month(Loan_issuedate)<12;


## Dashboard 2 
use financial_loandata;
-- Good loan vs bad loan KPI's 
select(count(case when loan_status ='Fully Paid' OR loan_status = 'current' then ID end)*100.0
/count(ID)) as 'good_loan_percentage' from bankloan;

-- Good loan Application
select count(ID) as 'Good loan Application' from bankloan where loan_status ='Fully Paid' or loan_status ='current';
-- good loan Funded Amount
select sum(loan_amount) as 'Good loan funded Amount' from bankloan where loan_status ='Fully paid' or loan_status='current';
-- good loan total received amount
select sum(total_payment) as 'Good loan total received amount' from bankloan where loan_status ='Fully paid' or loan_status='current';

-- bad loan
select count(ID) as ' bad loan application' from bankloan where loan_status='charged off';

-- bad loan application percentage
select count(case when loan_status='charged off' then ID end)*100/count(ID) as 'Bad loan percentage' from bankloan;

-- bad loan application
select count(ID) as 'bad loan application' from bankloan where loan_status= 'charged off';

-- bad loan funded amount
select sum(loan_amount) as 'bad loan funded amount' from bankloan where loan_status='charged off';

-- badd loan total received amount
select sum(total_payment) as 'bad loan received amount' from bankloan where loan_status='charged off';
-- loan status
SELECT
        loan_status,
        COUNT(ID) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(interest_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bankloan
    GROUP BY
        loan_status;
        
---------------------------------------------------
-- loan status of MTD
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bankloan
WHERE MONTH(loan_issuedate) = 12 
GROUP BY loan_status;

select round(avg(dti),4)*100 as 'MTD average DTI' from bankloan where year(Loan_issuedate)=2021;

-----------------------------------------------
-- bank loan report
-- month
select
month(loan_issuedate) as 'month number',
count(ID) as 'application',
sum(loan_amount) as 'funded amount',
sum(total_payment) as 'total amount received'
from bankloan
group by month(loan_issuedate)
order by month(loan_issuedate);

------------------------------------------------
-- state
select
address_state AS 'state',
count(ID) AS 'total_loan_application',
sum(loan_amount) As 'total funded amount',
sum(total_payment) AS 'total amount received'
from bankloan
group by(address_state)
order by(address_state);

------------------------------------------------
-- term
select
lone_term AS 'term',
count(ID) AS 'total loan application',
sum(loan_amount) AS  'total funded amount',
sum(total_payment) AS 'total amount received'
from bankloan
group by(lone_term)
order by(lone_term);

-------------------------------------------------
-- emoloyee length
select 
customer_working_since AS 'employee length',
count(ID) AS ' tatal loan application',
sum(loan_amount) AS 'total funded amount',
sum(total_payment) AS 'total amount received'
from bankloan
group by(customer_working_since)
order by(customer_working_since);

-----------------------------------------------------
-- purpose

select
purpose AS 'purpose',
count(ID) AS 'total loan application',
sum(loan_amount) AS 'total funded amount',
sum(total_payment) AS 'total amount received'
from bankloan
group by(purpose)
order by(purpose);

----------------------------------------
-- home ownership 

SELECT
home_ownership AS 'home ownership',
count(ID) AS 'total lone application',
sum(loan_amount) AS 'total funded amount',
sum(total_payment) AS' total amount recieved'
FROM  bankloan
GROUP BY (home_ownership)
ORDER BY (home_ownership);

--------------------------------------
-- See the results when we hit the Grade A in the filters for dashboards.

SELECT 
purpose AS 'purpose',
count(ID) AS 'total loan application',
sum(loan_amount) AS 'total funded amount',
sum(total_payment) AS 'total amount received'
from bankloan
WHERE GRADE='A'
group by(purpose)
order by(purpose);


