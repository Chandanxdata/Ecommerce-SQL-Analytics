-- E-commerce Analysis Queries


-- 1. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    SUM(p.amount) AS total_revenue
FROM orders o
JOIN payments p 
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY month
ORDER BY month;


-- 2. Total Orders Count
SELECT 
    COUNT(*) AS total_orders
FROM orders;


-- 3. Top Selling Products (by Quantity)
SELECT 
    pr.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products pr 
    ON oi.product_id = pr.product_id
GROUP BY pr.product_name
ORDER BY total_units_sold DESC;


-- 4. Revenue by Product Category
SELECT 
    pr.category,
    SUM(oi.quantity * pr.price) AS category_revenue
FROM order_items oi
JOIN products pr 
    ON oi.product_id = pr.product_id
GROUP BY pr.category
ORDER BY category_revenue DESC;


-- 5. Customer Lifetime Value (CLV)
SELECT 
    c.customer_name,
    SUM(p.amount) AS lifetime_value
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN payments p 
    ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY c.customer_name
ORDER BY lifetime_value DESC;


-- 6. Repeat vs One-Time Customers
SELECT 
    customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT 
        customer_id,
        CASE 
            WHEN COUNT(order_id) > 1 THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS customer_type
    FROM orders
    GROUP BY customer_id
) t
GROUP BY customer_type;


-- 7. Average Order Value (AOV)
SELECT 
    ROUND(AVG(amount), 2) AS average_order_value
FROM payments
WHERE payment_status = 'Completed';


-- 8. Order Status Distribution
SELECT 
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status;


-- 9. Order Cancellation Rate
SELECT 
    ROUND(
        SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*), 
        2
    ) AS cancellation_percentage
FROM orders;


-- 10. Preferred Payment Methods
SELECT 
    payment_method,
    COUNT(*) AS transaction_count
FROM payments
WHERE payment_status = 'Completed'
GROUP BY payment_method
ORDER BY transaction_count DESC;


-- 11. City-wise Customer Count
SELECT 
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;


-- 12. High-Value Orders
SELECT 
    order_id,
    amount
FROM payments
WHERE amount > (
    SELECT AVG(amount) FROM payments
)
ORDER BY amount DESC;
