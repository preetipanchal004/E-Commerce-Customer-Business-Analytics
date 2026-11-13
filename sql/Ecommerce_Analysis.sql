CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;
USE ecommerce_analytics;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_signup_date DATE,
    gender VARCHAR(20),
    age INT,
    age_group VARCHAR(20),
    state VARCHAR(50),
    city VARCHAR(50),
    pincode_prefix INT,
    customer_segment VARCHAR(30),
    preferred_device VARCHAR(30),
    preferred_payment_method VARCHAR(50),
    acquisition_channel VARCHAR(50),
    total_orders INT,
    total_spend DECIMAL(12,2),
    last_order_date DATE,
    average_order_value DECIMAL(12,2),
    customer_status VARCHAR(30),
    loyalty_tier VARCHAR(20)
);
CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(50),
    subcategory VARCHAR(80),
    brand VARCHAR(80),
    price DECIMAL(12,2),
    cost_price DECIMAL(12,2),
    discount_range VARCHAR(30),
    rating_average DECIMAL(3,2),
    rating_count INT,
    stock_quantity INT,
    product_launch_date DATE,
    product_type VARCHAR(30),
    return_rate_baseline DECIMAL(5,2)
);
CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    order_date DATE,
    order_time TIME,
    order_status VARCHAR(30),
    shipping_method VARCHAR(30),
    delivery_city VARCHAR(50),
    delivery_state VARCHAR(50),
    coupon_code VARCHAR(50),
    discount_percentage DECIMAL(5,2),
    marketing_channel VARCHAR(50),
    subtotal DECIMAL(12,2),
    shipping_fee DECIMAL(10,2),
    tax_amount DECIMAL(10,2),
    final_amount DECIMAL(12,2),
    campaign_id VARCHAR(20)
);
CREATE TABLE order_items (
    order_item_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    product_id VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(12,2),
    discount_percentage DECIMAL(5,2),
    item_revenue DECIMAL(12,2),
    item_cost DECIMAL(12,2),
    profit DECIMAL(12,2)
);
CREATE TABLE payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    payment_date DATE,
    payment_method VARCHAR(50),
    payment_status VARCHAR(30),
    amount_paid DECIMAL(12,2),
    transaction_fee DECIMAL(10,2),
    refund_amount DECIMAL(12,2)
);
CREATE TABLE shipments (
    shipment_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    warehouse_city VARCHAR(50),
    delivery_city VARCHAR(50),
    shipping_method VARCHAR(30),
    dispatch_date DATE,
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    delivery_days INT,
    delivery_status VARCHAR(40),
    delayed_flag TINYINT
);
CREATE TABLE returns (
    return_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    return_date DATE,
    return_reason VARCHAR(100),
    refund_amount DECIMAL(12,2),
    return_status VARCHAR(30)
);
CREATE TABLE customer_reviews (
    review_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    review_date DATE,
    rating INT,
    review_sentiment VARCHAR(20),
    verified_purchase BOOLEAN
);
CREATE TABLE marketing_campaigns (
    campaign_id VARCHAR(20) PRIMARY KEY,
    campaign_name VARCHAR(150),
    channel VARCHAR(50),
    campaign_start_date DATE,
    campaign_end_date DATE,
    campaign_type VARCHAR(50),
    target_segment VARCHAR(30),
    discount_percentage INT,
    conversions INT,
    revenue_generated DECIMAL(14,2),
    impressions INT,
    clicks INT,
    campaign_cost DECIMAL(14,2),
    roi DECIMAL(10,3)
);
USE ecommerce_analytics;

SHOW TABLES;
SELECT COUNT(*) FROM customers;
TRUNCATE TABLE customers;
SELECT COUNT(*) FROM customers;
TRUNCATE TABLE customers;
USE ecommerce_analytics;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'secure_file_priv';
TRUNCATE TABLE customers;
USE ecommerce_analytics;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers_cleaned.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@customer_id, @signup, @gender, @age, @age_group, @state, @city, @pincode, @segment, @device, @payment, @channel, @orders, @spend, @last_order, @aov, @status, @tier)
SET
customer_id = @customer_id,
customer_signup_date = NULLIF(@signup, ''),
gender = @gender,
age = NULLIF(@age, ''),
age_group = @age_group,
state = @state,
city = @city,
pincode_prefix = NULLIF(@pincode, ''),
customer_segment = @segment,
preferred_device = @device,
preferred_payment_method = @payment,
acquisition_channel = @channel,
total_orders = NULLIF(@orders, ''),
total_spend = NULLIF(@spend, ''),
last_order_date = NULLIF(@last_order, ''),
average_order_value = NULLIF(@aov, ''),
customer_status = @status,
loyalty_tier = @tier;

USE ecommerce_analytics;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products_cleaned.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(product_id, product_name, category, subcategory, brand, price, cost_price, discount_range, rating_average, rating_count, stock_quantity, @launch_date, product_type, return_rate_baseline)
SET product_launch_date = NULLIF(@launch_date, '');
TRUNCATE TABLE products;
SELECT COUNT(*) FROM products;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders_cleaned.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_id, customer_id, @order_date, @order_time, order_status, shipping_method, delivery_city, delivery_state, @coupon, @discount, marketing_channel, @subtotal, @shipping, @tax, @final, @campaign)
SET
order_date = NULLIF(@order_date, ''),
order_time = NULLIF(@order_time, ''),
coupon_code = NULLIF(@coupon, ''),
discount_percentage = NULLIF(@discount, ''),
subtotal = NULLIF(@subtotal, ''),
shipping_fee = NULLIF(@shipping, ''),
tax_amount = NULLIF(@tax, ''),
final_amount = NULLIF(@final, ''),
campaign_id = NULLIF(@campaign, '');
SELECT COUNT(*) FROM orders;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_items_cleaned.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_item_id, order_id, product_id, quantity, unit_price, discount_percentage, item_revenue, item_cost, profit);
SELECT COUNT(*) FROM order_items;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payments_cleaned.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(payment_id, order_id, @payment_date, payment_method, payment_status, amount_paid, transaction_fee, refund_amount)
SET payment_date = NULLIF(@payment_date, '');
SELECT COUNT(*) FROM payments;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/shipments_cleaned.csv'
INTO TABLE shipments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(shipment_id, order_id, warehouse_city, delivery_city, shipping_method, @dispatch, @expected, @actual, @days, delivery_status, delayed_flag)
SET
dispatch_date = NULLIF(@dispatch, ''),
expected_delivery_date = NULLIF(@expected, ''),
actual_delivery_date = NULLIF(@actual, ''),
delivery_days = NULLIF(@days, '');
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/returns_cleaned.csv'
INTO TABLE returns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(return_id, order_id, customer_id, product_id, @return_date, return_reason, refund_amount, return_status)
SET return_date = NULLIF(@return_date, '');
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_reviews_cleaned.csv'
INTO TABLE customer_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(review_id, order_id, customer_id, product_id, @review_date, rating, review_sentiment, @verified)
SET
review_date = NULLIF(@review_date, ''),
verified_purchase = CASE
    WHEN @verified = 'True' THEN 1
    WHEN @verified = 'False' THEN 0
    ELSE NULL
END;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/marketing_campaigns_cleaned.csv'
INTO TABLE marketing_campaigns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(campaign_id, campaign_name, channel, @start_date, @end_date, campaign_type, target_segment, discount_percentage, conversions, revenue_generated, impressions, clicks, campaign_cost, roi)
SET
campaign_start_date = NULLIF(@start_date, ''),
campaign_end_date = NULLIF(@end_date, '');
USE ecommerce_analytics;

SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'shipments', COUNT(*) FROM shipments
UNION ALL SELECT 'returns', COUNT(*) FROM returns
UNION ALL SELECT 'customer_reviews', COUNT(*) FROM customer_reviews
UNION ALL SELECT 'marketing_campaigns', COUNT(*) FROM marketing_campaigns;
SELECT
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS total_revenue,
    ROUND(AVG(final_amount), 2) AS average_order_value,
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders;
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS monthly_revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;
SELECT p.product_id, p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.item_revenue), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;
SELECT p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.item_revenue), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC
LIMIT 10;
SELECT c.customer_id, c.city, c.customer_segment,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.final_amount), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.city, c.customer_segment
ORDER BY total_spent DESC
LIMIT 10;
SELECT c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.final_amount), 2) AS total_revenue,
    ROUND(AVG(o.final_amount), 2) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;
SELECT
    order_status,
    COUNT(order_id) AS total_orders,
    ROUND(
        COUNT(order_id) * 100.0 /
        (SELECT COUNT(*) FROM orders), 2
    ) AS percentage
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
SELECT payment_method,
    COUNT(payment_id) AS total_transactions,
    ROUND(SUM(amount_paid), 2) AS total_amount,
    ROUND(AVG(amount_paid), 2) AS average_payment
FROM payments
GROUP BY payment_method
ORDER BY total_transactions DESC;
SELECT return_reason,
    COUNT(return_id) AS total_returns,
    ROUND(SUM(refund_amount), 2) AS total_refund
FROM returns
GROUP BY return_reason
ORDER BY total_returns DESC;
SELECT
    COUNT(shipment_id) AS total_shipments,
    ROUND(AVG(delivery_days), 2) AS average_delivery_days,
    SUM(delayed_flag) AS delayed_shipments,
    ROUND(
        SUM(CASE WHEN delayed_flag = 0 THEN 1 ELSE 0 END) * 100.0 /
        COUNT(shipment_id), 2
    ) AS on_time_percentage
FROM shipments;
SELECT campaign_name, channel, conversions,
    ROUND(revenue_generated, 2) AS revenue,
    ROUND(campaign_cost, 2) AS campaign_cost,
    ROUND(roi, 2) AS ROI
FROM marketing_campaigns
ORDER BY roi DESC
LIMIT 10;
SELECT
    p.brand,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(SUM(oi.item_revenue), 2) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.brand
ORDER BY total_revenue DESC
LIMIT 10;
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    order_status,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m'),
    order_status
ORDER BY month, order_status;
SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.item_revenue), 2) AS total_revenue,
    ROUND(SUM(oi.profit), 2) AS total_profit
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC
LIMIT 10;
SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-time Customers'
        WHEN total_orders > 1 THEN 'Repeat Customers'
    END AS customer_type,
    COUNT(customer_id) AS total_customers
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
) AS customer_orders
GROUP BY customer_type;
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS lifetime_value
FROM orders
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;
SELECT
    delivery_city,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS total_revenue
FROM orders
GROUP BY delivery_city
ORDER BY total_revenue DESC
LIMIT 10;
SELECT
    review_sentiment,
    COUNT(review_id) AS total_reviews,
    ROUND(AVG(rating), 2) AS average_rating
FROM customer_reviews
GROUP BY review_sentiment
ORDER BY total_reviews DESC;
SELECT
    p.category,
    COUNT(r.return_id) AS total_returns,
    ROUND(SUM(r.refund_amount), 2) AS total_refund_amount
FROM returns r
JOIN products p
    ON r.product_id = p.product_id
GROUP BY p.category
ORDER BY total_returns DESC;
SELECT
    channel,
    COUNT(campaign_id) AS total_campaigns,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(revenue_generated), 2) AS total_revenue,
    ROUND(SUM(campaign_cost), 2) AS total_campaign_cost,
    ROUND(
        (SUM(revenue_generated) - SUM(campaign_cost))
        / SUM(campaign_cost), 2
    ) AS overall_roi
FROM marketing_campaigns
GROUP BY channel
ORDER BY total_revenue DESC;
SELECT
    COUNT(order_id) AS total_orders,
    ROUND(SUM(final_amount), 2) AS total_revenue,
    ROUND(AVG(final_amount), 2) AS average_order_value,
    COUNT(DISTINCT customer_id) AS total_customers
FROM orders;