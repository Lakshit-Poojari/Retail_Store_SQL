create table Retail_Sales 
				(
				transactions_id	int Primary key,
				sale_date	Date,
				sale_time	time,
				customer_id	int,
				gender	 varchar(20),
				age	int,
				category	varchar(20),
				quantity	Int,
				price_per_unit	Float,
				cogs	Float,
				total_sale Float
				)

Select * from retail_sales

/*Record Count: Determine the total number of records in the dataset.*/
select count(*) from retail_sales

/*Customer Count: Find out how many unique customers are in the dataset.*/
select count (distinct customer_id) from retail_sales

/*Category Count: Identify all unique product categories in the dataset.*/
select count (distinct category) from retail_sales
select distinct category from retail_sales

/*Category Count: Identify all unique product categories in the dataset.*/
Select * from retail_sales
	where 
		transactions_id	is null or	sale_date	is null or	sale_time	is null or
		customer_id	is null or	gender	 is null or		age	is null or
		category is null or	quantiy	is null or	price_per_unit	is null or
		cogs	is null or		total_sale is null 

/*Null Value Check: Check for any null values in the dataset and delete records with missing data.*/
delete  from retail_sales
	where 
		transactions_id	is null or	sale_date	is null or	sale_time	is null or
		customer_id	is null or	gender	 is null or		age	is null or
		category is null or	quantiy	is null or	price_per_unit	is null or
		cogs	is null or		total_sale is null 

/*Write a SQL query to retrieve all columns for sales made on '2022-11-05*/
Select * from retail_sales
	where sale_date = '2022-11-05';

/*Write a SQL query to retrieve all transactions where the category is 'Clothing'
and the quantity sold is more than 4 in the month of Nov-2022*/
select * from retail_sales
	where category = 'Clothing' and quantiy >= '4' and to_char(sale_date, 'YYYY-MM') = '2022-11';

/*Write a SQL query to calculate the total sales (total_sale) for each category.*/
select category, sum(total_sale) as net_sale, count(*) as total_order from retail_sales
	group by(category)
	order by net_sale

/*Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.*/
select round(avg(age)) as avrage_age from retail_sales
	where category = 'Beauty';

/*Write a SQL query to find all transactions where the total_sale is greater than 1000.*/
select * from retail_sales
	where total_sale > '1000';

/*Write a SQL query to find the total number of transactions (transaction_id) made by each gender
in each category.*/
select count(transactions_id) as Total_transaction, gender, category from retail_sales
	group by(gender, category)
	order by Total_transaction DESC

/*Write a SQL query to calculate the average sale for each month. Find out best selling month in each year*/
select 
		extract(YEAR from sale_date) as Year, 
		extract(MONTH from sale_date) as Month,
		AVG(total_sale) AS Avg_sale from retail_sales
			group by (Year, Month)
			Order by Year, Month ASC
	
/*Write a SQL query to find the top 5 customers based on the highest total sales */
select distinct(customer_id) as customer, sum(total_sale) as total_sale from retail_sales
	group by(customer)
	order by total_sale DESC
	LIMIT 5

/*Write a SQL query to find the number of unique customers who purchased items from each category.*/
select count(distinct(customer_id)) as no_of_unique_customer, category from retail_sales
	group by (category)

/*Write a SQL query to create each shift and number of orders (Example Morning <12, 
Afternoon Between 12 & 17, Evening >17)*/
select 
	case 
		when extract(HOUR from sale_time) < 12 THEN 'Morning'
		when extract(HOUR from sale_time) Between 12 and 17  Then 'Afternoon'
		else 'Evening'
		end as shift,
		count(*) as Total_order from retail_sales
group by Shift
order by total_order DESC