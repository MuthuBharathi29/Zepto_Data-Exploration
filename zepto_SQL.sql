use zepto_sql_project;
select * from zepto limit 5;


CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(100),
    name VARCHAR(100) NOT NULL,
    mrp NUMERIC(8 , 2 ),
    discountpercent NUMERIC(5 , 2 ),
    availableQuantity INT,
    discountedSellingPrice NUMERIC(8 , 2 ),
    weightInGms INT,
    outOfStock BOOLEAN,
    quantity INT
);

 -- Data Exploration
 
-- Samaple Data
 select * from zepto limit 11;
 
-- count of Rows 
select count(*) from zepto;
-- Cheeck null values
 SELECT 
    *
FROM
    zepto
WHERE
    category IS NULL OR name IS NULL
        OR mrp IS NULL
        OR discountpercent IS NULL
        OR availableQuantity IS NULL
        OR discountedSellingPrice IS NULL
        OR weightInGms IS NULL
        OR outOfStock IS NULL
        OR quantity IS NULL;
        
        
-- Different Product categories
 select distinct(category) from zepto;
 
-- Products In stock vs Out of stock 
SELECT 
    outOfStock, COUNT(sku_id)
FROM
    zepto
GROUP BY outOfStock;

-- Products names present multiple times 
SELECT 
    name, COUNT(sku_id) AS present
FROM
    zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

-- Data Cleaning

-- Products with price=0
select * from zepto 
where mrp=0 or discountedSellingPrice=0;

-- Delete the record which price=0
begin;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM zepto
WHERE mrp = 0;

SET SQL_SAFE_UPDATES = 1;  -- Optional: re-enable safe mode afterward

commit;

-- Convert paise into rupees
begin;
SET SQL_SAFE_UPDATES = 0;

UPDATE zepto
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

SET SQL_SAFE_UPDATES = 1;  -- Optional: re-enable safe mode afterward

select mrp,discountedSellingPrice from zepto limit 10;
commit;

-- Business Questions

-- QN 1: Find the top 10 best value products based on the discount percentage
select distinct(name) , mrp,discountpercent
from zepto 
order by discountpercent desc limit 10;

-- QN 2: What are the products are high in MRP but out of stock?
select distinct(name),mrp
from zepto 
where outOfStock=0 and mrp>300
order by mrp desc;

-- QN 3: Calculate estimated revenue for each category
select category,sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto 
group by category
order by total_revenue desc;

-- QN 4: Find all products where MRP is greater than 500 and discount is less than 10%
select distinct(name) , mrp,discountpercent
from zepto 
where mrp>500 and discountpercent<10
order by mrp desc , discountpercent desc;

-- QN 5: Identify the top 5 categories offering the highest average discount percentage
select category,round(avg(discountpercent),2) as discount
from zepto 
group by category
order by discount desc limit 5;

-- QN 6: Find the price per gram for products above 100g and sort by best values
select distinct name, discountedSellingPrice, weightInGms, round(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto 
where weightInGms>100
order by price_per_gram ;

-- Qn 7: Group the products into categories like low, medium, bulk
select distinct name ,category,weightInGms,
case when weightInGms<=500 then 'low'
when weightInGms <=2000 then 'medium'
else 'bulk'
end as category_1
from zepto;

-- QN 8: What is the total inventory weight per category
select category,sum(weightInGms) as total_weight
from zepto 
group by category
order by total_weight;
