select * from Customer;

--What is no of customers churned from the total customers?
select 
	count(customerid) as exited_customer 
	from Customer 
	where exited='1';

--What is the overall customer churn rate of the bank?
select 
    (count(case when exited = '1' then customerid end) * 100.0 / count(customerid)) as churn_rate
from Customer;

--Which geography has the highest customer churn?
select
	count(customerid) as customers,geography,exited
	from Customer
	where exited='1'
	group by geography,exited
	order by customers desc limit 1;

--Which age group has the highest churn rate?
select
	case
		when age between 18 and 30 then 'Young'
		when age between 31 and 59 then 'Middle'
		else 'Old'
	end as age_group,
	count(customerid) as customers
	from Customer
	where exited='1'
	group by age_group
	order by customers desc;

--Does Gender influence customer churn?
select count(customerid) as customers,gender,exited from Customer group by gender,exited order by customers desc;

--Are inactive members more likely to leave the bank?
select count(customerid) as customers,isactivemember,exited from customer where isactivemember='0' group by isactivemember,exited order by customers desc;

--Does having a credit card impact customer retention?
select count(customerid) as customers,hascrcard,exited from customer group by hascrcard,exited order by customers;

--Do customers with higher credit scores own more bank products?
select count(customerid) as customers,creditscore,numofproducts from customer where creditscore>=750 group by numofproducts,creditscore order by customers desc;

--Which credit score category (Low, Medium, High) has the highest churn?
select 
	case
		when creditscore<650 then 'Low'
		when creditscore between 651 and 750 then 'Medium'
		else 'High'
	end as credit_category,
	count(customerid) as customers,exited
from Customer
where exited='1'
group by credit_category,exited
order by customers desc;

--What is the average account balance of churned customers?
select round(avg(balance),2) as balance,exited from customer where exited='1' group by exited;

--Which number of products is most commonly used by customers?
select numofproducts as products,count(customerid) as customers from Customer group by products order by customers desc;

--Which customer segment contributes the highest total balance?
select
	case
		when age between 18 and 30 then 'Young'
		when age between 31 and 59 then 'Middle'
		else 'Old'
	end as customer_segment,
	round(sum(balance),2) as total_balance
	from Customer
	group by customer_segment
	order by total_balance desc;

--Which geography has customers with highest average balance?
select count(customerid) as customers,round(avg(balance),2),geography from Customer group by geography order by avg(balance);

--What is the average salary of retained vs churned customers?
select round(avg(estimatedsalary),2) as salary,exited from Customer group by exited;

--What customer characteristics are most common among churned customers?
select
	gender,
	geography,
	numofproducts,
	isactivemember,
	count(customerid) as churned_customers
	from Customer
	where exited='1'
	group by gender,geography,numofproducts,isactivemember
	order by churned_customers desc
	limit 10;