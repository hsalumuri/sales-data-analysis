-- Run schema.sql and insert_data.sql first. Revenue = quantity * product price.

-- 1. Inspect customers.
SELECT * FROM customers;

-- 2. Inspect products.
SELECT * FROM products;

-- 3. Inspect transactions.
SELECT * FROM sales;

-- 4. Total revenue.
SELECT SUM(s.quantity * p.price) AS total_revenue
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id;

-- 5. Revenue and units sold by product.
SELECT p.product_name,
       SUM(s.quantity) AS total_quantity_sold,
       SUM(s.quantity * p.price) AS product_revenue
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC;

-- 6. Revenue by city.
SELECT c.city, SUM(s.quantity * p.price) AS city_revenue
FROM sales AS s
JOIN customers AS c ON s.customer_id = c.customer_id
JOIN products AS p ON s.product_id = p.product_id
GROUP BY c.city ORDER BY city_revenue DESC;

-- 7. Customer spending.
SELECT c.customer_name, c.city,
       SUM(s.quantity * p.price) AS total_spent
FROM sales AS s
JOIN customers AS c ON s.customer_id = c.customer_id
JOIN products AS p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC;

-- 8. Monthly revenue using SQLite's strftime.
SELECT strftime('%Y-%m', s.sale_date) AS sales_month,
       SUM(s.quantity * p.price) AS monthly_revenue
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY sales_month ORDER BY sales_month;

-- 9. Revenue by category.
SELECT p.category, SUM(s.quantity * p.price) AS category_revenue
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY p.category ORDER BY category_revenue DESC;

-- 10. Customers spending more than ₹10,000.
SELECT c.customer_name, SUM(s.quantity * p.price) AS total_spent
FROM sales AS s
JOIN customers AS c ON s.customer_id = c.customer_id
JOIN products AS p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(s.quantity * p.price) > 10000
ORDER BY total_spent DESC;

-- 11. Transactions above ₹10,000.
SELECT s.sale_id, c.customer_name, p.product_name, s.quantity, p.price,
       s.quantity * p.price AS sale_amount
FROM sales AS s
JOIN customers AS c ON s.customer_id = c.customer_id
JOIN products AS p ON s.product_id = p.product_id
WHERE s.quantity * p.price > 10000
ORDER BY sale_amount DESC;

-- 12. Products with no sales (LEFT JOIN).
SELECT p.product_id, p.product_name, p.category
FROM products AS p
LEFT JOIN sales AS s ON p.product_id = s.product_id
WHERE s.product_id IS NULL;

-- 13. Number of transactions per product, including products with no sales.
SELECT p.product_name, COUNT(s.sale_id) AS times_sold
FROM products AS p
LEFT JOIN sales AS s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name
ORDER BY times_sold ASC, p.product_name;

-- 14. Overall sales summary.
SELECT COUNT(*) AS total_orders,
       SUM(s.quantity) AS total_units_sold,
       COUNT(DISTINCT s.customer_id) AS unique_customers,
       SUM(s.quantity * p.price) AS total_revenue,
       ROUND(AVG(s.quantity * p.price), 2) AS average_transaction_value
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id;

-- 15. Customers spending above average customer spend (subqueries).
SELECT customer_name, total_spent
FROM (
    SELECT c.customer_name,
           SUM(s.quantity * p.price) AS total_spent
    FROM sales AS s
    JOIN customers AS c ON s.customer_id = c.customer_id
    JOIN products AS p ON s.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
) AS customer_totals
WHERE total_spent > (
    SELECT AVG(customer_spend)
    FROM (
        SELECT SUM(s2.quantity * p2.price) AS customer_spend
        FROM sales AS s2 JOIN products AS p2 ON s2.product_id = p2.product_id
        GROUP BY s2.customer_id
    ) AS customer_averages
)
ORDER BY total_spent DESC;

-- 16. Top product by revenue.
SELECT p.product_name, SUM(s.quantity * p.price) AS product_revenue
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC LIMIT 1;

-- 17. Second-highest earning product (LIMIT/OFFSET).
SELECT p.product_name, SUM(s.quantity * p.price) AS product_revenue
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC LIMIT 1 OFFSET 1;

-- 18. Top three products by revenue.
SELECT p.product_name, SUM(s.quantity * p.price) AS product_revenue
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC LIMIT 3 OFFSET 0;

-- 19. Product revenue share as a percentage of total revenue.
SELECT p.product_name,
       SUM(s.quantity * p.price) AS product_revenue,
       ROUND(
           SUM(s.quantity * p.price) * 100.0 /
           (SELECT SUM(s2.quantity * p2.price)
            FROM sales AS s2 JOIN products AS p2 ON s2.product_id = p2.product_id),
           2
       ) AS revenue_percentage
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC;

-- 20. Monthly revenue status with CASE.
SELECT strftime('%Y-%m', s.sale_date) AS sales_month,
       SUM(s.quantity * p.price) AS monthly_revenue,
       CASE WHEN SUM(s.quantity * p.price) > 50000
            THEN 'High Revenue' ELSE 'Low Revenue' END AS revenue_status
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
GROUP BY sales_month ORDER BY sales_month;

-- 21. Repeat customers and their total spend.
SELECT c.customer_name, COUNT(s.sale_id) AS number_of_orders,
       SUM(s.quantity * p.price) AS total_spent
FROM sales AS s
JOIN customers AS c ON s.customer_id = c.customer_id
JOIN products AS p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(s.sale_id) > 1
ORDER BY number_of_orders DESC;

-- 22. Running total of revenue (window function).
SELECT s.sale_date, s.sale_id, p.product_name,
       s.quantity * p.price AS sale_revenue,
       SUM(s.quantity * p.price) OVER (
           ORDER BY s.sale_date, s.sale_id
       ) AS running_total
FROM sales AS s JOIN products AS p ON s.product_id = p.product_id
ORDER BY s.sale_date, s.sale_id;
