-- Nykaa Beauty Product Analysis - SQL queries
USE nykaa_db;

-- 1. KPIs
SELECT SUM(reviews)                      AS total_reviews,
       ROUND(AVG(price), 2)              AS avg_price,
       ROUND(SUM(revenue) / 1000000, 2)  AS revenue_millions
FROM nykaa_clean;

-- 2. Top 5 brands by reviews
SELECT brand, SUM(reviews) AS total_reviews
FROM nykaa_clean
GROUP BY brand
ORDER BY total_reviews DESC
LIMIT 5;

-- 3. Reviews share by category
SELECT category,
       SUM(reviews) AS total_reviews,
       ROUND(SUM(reviews) * 100 / (SELECT SUM(reviews) FROM nykaa_clean), 2) AS pct
FROM nykaa_clean
GROUP BY category
ORDER BY total_reviews DESC;

-- 4. Average price by category
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM nykaa_clean
GROUP BY category
ORDER BY avg_price DESC;

-- 5. Cruelty free vs non cruelty free
SELECT cruelty_free,
       COUNT(*) AS products,
       ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM nykaa_clean), 2) AS pct
FROM nykaa_clean
GROUP BY cruelty_free;

-- 6. Revenue by brand (in millions)
SELECT brand, ROUND(SUM(revenue) / 1000000, 2) AS revenue_m
FROM nykaa_clean
GROUP BY brand
ORDER BY revenue_m DESC;

-- 7. Highest rated product
SELECT product_name, rating
FROM nykaa_clean
ORDER BY rating DESC
LIMIT 1;
