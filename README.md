# Zepto_Data-Exploration
## Project Overview

This project analyzes Zepto’s product dataset using SQL. The goal is to perform data exploration, cleaning, and business insights generation from product-level information such as MRP, discounts, stock availability, and weights.

The analysis helps answer key business questions like:

1.Which products offer the best discounts?
2.Which categories drive the highest revenue?
3.What products are out of stock despite being high in demand?
4.How to classify inventory into low, medium, and bulk categories?

## Data Exploration & Cleaning

1.Checked for null values and duplicates.

2.Identified products with zero MRP or selling price and removed them.

3.Converted paise into rupees for consistent pricing.

4.Grouped products based on weight categories (Low, Medium, Bulk).

## Business Questions Solved

Q1: Top 10 best value products based on discount percentage.

Q2: High MRP products that are out of stock.

Q3: Estimated revenue per category.

Q4: Products with MRP > 500 and discount < 10%.

Q5: Top 5 categories with the highest average discount percentage.

Q6: Price per gram for products above 100g (best value sorting).

Q7: Categorizing inventory into Low, Medium, Bulk.

Q8: Total inventory weight per category.

## Insights Gained

Discount analysis helps identify best-value deals.
Revenue concentration shows which categories are driving sales.
Stock status analysis helps track supply chain efficiency.
Weight classification enables better inventory segmentation.
