-- Item inventory
SELECT * FROM thrift_sales;

-- Row counts
SELECT COUNT(*) FROM thrift_sales;

-- Sold vs unsold
SELECT is_sold, COUNT(*) 
FROM thrift_sales 
GROUP BY is_sold;

-- Price sanity
SELECT 
    MIN(posted_price), 
    MAX(posted_price),
    MIN(sold_price), 
    MAX(sold_price)
FROM thrift_sales;

-- 1. Which month's had the highest sales volume?
SELECT month, COUNT(*) AS items_sold
FROM thrift_sales
WHERE is_sold = 1
GROUP BY month
ORDER BY items_sold DESC;

-- 2. What 5 brand's sell the most by price?
SELECT brand_name, ROUND(SUM(sold_price),2) AS total_sales_value
FROM thrift_sales
WHERE is_sold = 1
GROUP BY brand_name
ORDER BY total_sales_value DESC
LIMIT 5;

-- 3. What is the average price sold per category?
SELECT category, ROUND(AVG(sold_price),2) AS avg_sold_price
FROM thrift_sales
WHERE is_sold = 1
GROUP BY category
ORDER BY avg_sold_price DESC;

-- 4. Which product categories sell the most?
SELECT category, COUNT(*) AS item_sold
FROM thrift_sales
WHERE is_sold = 1
GROUP BY category
ORDER BY item_sold DESC;

-- 5. Categories with highest negotiation variance and lowest percentage of asking price captured
SELECT
    category,
    ROUND(AVG(posted_price), 2) AS avg_posted_price,
    ROUND(AVG(sold_price), 2) AS avg_sold_price,
    ROUND(AVG(posted_price - sold_price), 2) AS avg_price_gap,
    ROUND(AVG(sold_price / posted_price) * 100, 2) AS pct_price_captured
FROM thrift_sales
WHERE is_sold = 1
GROUP BY category
ORDER BY avg_price_gap DESC, pct_price_captured ASC;


