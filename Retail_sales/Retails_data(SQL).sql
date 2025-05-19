--Creating a Table
CREATE TABLE retail_customer_data (
    customer_id INT,
    age INT,
    gender VARCHAR(10),
    income_bracket VARCHAR(15),
    loyalty_program VARCHAR(5),
    membership_years INT,
    churned VARCHAR(5),
    marital_status VARCHAR(15),
    number_of_children INT,
    education_level VARCHAR(20),
    occupation VARCHAR(50),
    transaction_id INT,
    transaction_date TIMESTAMP,
    product_id INT,
    product_category VARCHAR(30),
    quantity INT,
    unit_price FLOAT,
    discount_applied FLOAT,
    payment_method VARCHAR(20),
    store_location VARCHAR(50),
    transaction_hour INT,
    day_of_week VARCHAR(10),
    week_of_year INT,
    month_of_year INT,
    avg_purchase_value FLOAT,
    purchase_frequency VARCHAR(15),
    last_purchase_date TIMESTAMP,
    avg_discount_used FLOAT,
    preferred_store VARCHAR(50),
    online_purchases INT,
    in_store_purchases INT,
    avg_items_per_transaction FLOAT,
    avg_transaction_value FLOAT,
    total_returned_items INT,
    total_returned_value FLOAT,
    total_sales FLOAT,
    total_transactions INT,
    total_items_purchased INT,
    total_discounts_received FLOAT,
    avg_spent_per_category FLOAT,
    max_single_purchase_value FLOAT,
    min_single_purchase_value FLOAT,
    product_name VARCHAR(100),
    product_brand VARCHAR(50),
    product_rating FLOAT,
    product_review_count INT,
    product_stock INT,
    product_return_rate FLOAT,
    product_size VARCHAR(20),
    product_weight FLOAT,
    product_color VARCHAR(20),
    product_material VARCHAR(30),
    product_manufacture_date TIMESTAMP,
    product_expiry_date TIMESTAMP,
    product_shelf_life INT,
    promotion_id INT,
    promotion_type VARCHAR(30),
    promotion_start_date TIMESTAMP,
    promotion_end_date TIMESTAMP,
    promotion_effectiveness VARCHAR(15),
    promotion_channel VARCHAR(30),
    promotion_target_audience VARCHAR(50),
    customer_zip_code INT,
    customer_city VARCHAR(50),
    customer_state VARCHAR(50),
    store_zip_code INT,
    store_city VARCHAR(50),
    store_state VARCHAR(50),
    distance_to_store FLOAT,
    holiday_season VARCHAR(5),
    season VARCHAR(10),
    weekend VARCHAR(5),
    customer_support_calls INT,
    email_subscriptions VARCHAR(5),
    app_usage VARCHAR(15),
    website_visits INT,
    social_media_engagement VARCHAR(15),
    days_since_last_purchase INT
);
--------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM retail_customer_data;

--------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Clean missing/null records
DELETE FROM retail_customer_data
WHERE product_id IS NULL
   OR product_category IS NULL
   OR quantity IS NULL
   OR unit_price IS NULL
   OR total_sales IS NULL;

--------------------------------------------------------------------------------------------------------------------------------------------------------

--2. Calculate profit margins by product category
SELECT 
    product_category,
    SUM(total_sales) AS total_sales,
    SUM(total_sales - (0.7 * unit_price * quantity)) AS estimated_profit,
    ROUND(
        (SUM(total_sales - (0.7 * unit_price * quantity)) * 100.0 / NULLIF(SUM(total_sales), 0))::NUMERIC,
        2
    ) AS estimated_margin_percent
FROM 
    retail_customer_data
GROUP BY 
    product_category
ORDER BY 
    estimated_margin_percent ASC;

--------------------------------------------------------------------------------------------------------------------------------------------------------

--3. Data for correlation: Inventory days vs profitability
SELECT 
    product_id,
    product_category,
    product_stock,
    total_sales,
    total_items_purchased,
    (product_stock * 1.0 / NULLIF(total_items_purchased, 0)) AS inventory_days,
    (total_sales * 1.0 / NULLIF(total_items_purchased, 0)) AS avg_sale_price_per_item
FROM 
    retail_customer_data;

--------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. Seasonal behavior of products
SELECT 
    product_category,
    season,
    SUM(total_sales) AS seasonal_sales,
    COUNT(DISTINCT transaction_id) AS transaction_count
FROM 
    retail_customer_data
GROUP BY 
    product_category, season
ORDER BY 
    product_category, season;
--------------------------------------------------------------------------------------------------------------------------------------------------------

--5. Identify slow-moving and overstocked items
SELECT 
    product_id,
    product_category,
    product_stock,
    total_items_purchased,
    (product_stock - total_items_purchased) AS overstock_level
FROM 
    retail_customer_data
WHERE 
    total_items_purchased < 10
ORDER BY 
    overstock_level DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------------

--6. Power BI Export Query
SELECT 
    store_state AS region,
    store_city,
    store_location,
    product_category,
    season,
    month_of_year,
    week_of_year,
    SUM(total_sales) AS total_sales,
    SUM(quantity) AS total_quantity,
    AVG(unit_price) AS avg_unit_price,
    COUNT(DISTINCT transaction_id) AS transaction_count
FROM 
    retail_customer_data
GROUP BY 
    store_state, store_city, store_location, product_category, season, month_of_year, week_of_year
ORDER BY 
    region, product_category, season;

--------------------------------------------------------------------------------------------------------------------------------------------------------