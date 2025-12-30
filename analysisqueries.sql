/* Query 1 
   Title: Orders and Revenue by Customer City
   Purpose: Identify cities generating highest orders and revenue */
SELECT
  c.customer_city,
  COUNT(DISTINCT o.order_id) AS total_orders,
  SUM(p.amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY c.customer_city
ORDER BY total_revenue DESC;

/* Query 2
   Title: Revenue by Product Category
   Purpose: Find top performing product categories */
SELECT
  pr.category,
  SUM(p.amount) AS revenue
FROM products pr
JOIN order_items oi ON pr.product_id = oi.product_id
JOIN payments p ON oi.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY pr.category
ORDER BY revenue DESC;

/* Query 3
   Title: Repeat Customers
   Purpose: Identify customers with more than 5 orders */
SELECT
  customer_id,
  COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 5;

/* Query 4
   Title: High Revenue Cities
   Purpose: Cities generating revenue above 50 lakh */
SELECT
  c.customer_city,
  SUM(p.amount) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY c.customer_city
HAVING SUM(p.amount) > 5000000;

/* Query 5
   Title: Above Average Spending Customers
   Purpose: Find customers spending more than average */
SELECT customer_id
FROM payments
GROUP BY customer_id
HAVING SUM(amount) >
(
  SELECT AVG(total_spent)
  FROM (
    SELECT SUM(amount) AS total_spent
    FROM payments
    GROUP BY customer_id
  ) avg_table
);

/* Query 6
   Title: Products Never Ordered
   Purpose: Identify products with zero demand */
SELECT product_id
FROM products
WHERE product_id NOT IN (
  SELECT DISTINCT product_id
  FROM order_items
);

/* Query 7
   Title: Monthly Revenue Trend
   Purpose: Analyze revenue over time */
SELECT
  DATE_FORMAT(o.order_date, '%Y-%m') AS month,
  SUM(p.amount) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY month
ORDER BY month;

/* Query 8
   Title: Recent Orders
   Purpose: Orders placed in last 30 days */
SELECT COUNT(*) AS recent_orders
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

/* Query 9
   Title: Top Customers by Revenue
   Purpose: Identify highest value customers */
SELECT
  o.customer_id,
  SUM(p.amount) AS total_spent
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 5;

/* Query 10
   Title: Top Products per Category
   Purpose: Best performing products in each category */
SELECT category, product_id, revenue
FROM (
  SELECT
    pr.category,
    pr.product_id,
    SUM(p.amount) AS revenue,
    RANK() OVER (
      PARTITION BY pr.category
      ORDER BY SUM(p.amount) DESC
    ) AS rnk
  FROM products pr
  JOIN order_items oi ON pr.product_id = oi.product_id
  JOIN payments p ON oi.order_id = p.order_id
  WHERE p.payment_status = 'Completed'
  GROUP BY pr.category, pr.product_id
) ranked
WHERE rnk <= 3;

/* Query 11
   Title: Payment Method Performance
   Purpose: Analyze payment success by method */
SELECT
  payment_method,
  COUNT(*) AS total_transactions,
  SUM(payment_status = 'Completed') AS successful_transactions
FROM payments
GROUP BY payment_method;

/* Query 12
   Title: Average Order Value
   Purpose: Calculate average revenue per order */
SELECT
  SUM(amount) / COUNT(DISTINCT order_id) AS avg_order_value
FROM payments
WHERE payment_status = 'Completed';


























