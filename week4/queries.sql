USE ecommerce_db;

-- ============================================================
-- 35 SQL QUERIES - ECOMMERCE PROJECT
-- ============================================================


-- Query 1: Basic SELECT
SELECT *
FROM customers;


-- Query 2: WHERE
SELECT *
FROM customers
WHERE city = 'Bengaluru';


-- Query 3: ORDER BY
SELECT
    product_name,
    price
FROM products
ORDER BY price DESC;


-- Query 4: LIMIT
SELECT
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 3;


-- Query 5: Column Aliases
SELECT
    product_name AS Product,
    price AS Price,
    category AS Category
FROM products;


-- Query 6: IS NULL
SELECT
    name,
    city
FROM customers
WHERE city IS NULL;


-- Query 7: COALESCE
SELECT
    name,
    COALESCE(city, 'City Not Provided') AS city
FROM customers;


-- Query 8: NULLIF
SELECT
    product_name,
    NULLIF(price, 0) AS available_price
FROM products;


-- Query 9: COUNT
SELECT
    COUNT(*) AS total_customers
FROM customers;


-- Query 10: SUM
-- Calculate total sales from order items and product prices
SELECT
    SUM(p.price * oi.quantity) AS total_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id;


-- Query 11: AVG
-- Calculate average order value
SELECT
    AVG(order_total) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(p.price * oi.quantity) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY o.order_id
) AS order_totals;


-- Query 12: GROUP BY
SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;


-- Query 13: HAVING
SELECT
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status
HAVING COUNT(*) > 2;


-- Query 14: INNER JOIN
SELECT
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 15: LEFT JOIN
SELECT
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 16: RIGHT JOIN
SELECT
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 17: FULL OUTER JOIN equivalent using UNION
SELECT
    c.name AS customer_name,
    o.order_id,
    o.status
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id

UNION

SELECT
    c.name AS customer_name,
    o.order_id,
    o.status
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id;


-- Query 18: CASE WHEN
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 30000 THEN 'Expensive'
        WHEN price >= 5000 THEN 'Medium'
        ELSE 'Affordable'
    END AS price_category
FROM products;


-- Query 19: String Functions
SELECT
    product_name,
    UPPER(product_name) AS uppercase_name,
    LENGTH(product_name) AS name_length
FROM products;


-- Query 20: Date Functions
SELECT
    order_id,
    order_date,
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month
FROM orders;


-- Query 21: Customer Spending
SELECT
    c.name AS customer_name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;


-- Query 22: Top 5 Products by Price
SELECT
    product_name,
    category,
    price
FROM products
ORDER BY price DESC
LIMIT 5;


-- Query 23: Top-Selling Products
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC;


-- Query 24: Product Revenue
SELECT
    p.product_name,
    SUM(oi.quantity * p.price) AS revenue
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC;


-- Query 25: Order Trends by Month
SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.price * oi.quantity) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY
    order_year,
    order_month;


-- Query 26: Customer Order Count
SELECT
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;


-- Query 27: Average Spending per Customer
SELECT
    c.name AS customer_name,
    AVG(order_totals.order_total) AS average_order_value
FROM customers c
JOIN (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(p.price * oi.quantity) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY
        o.order_id,
        o.customer_id
) AS order_totals
    ON c.customer_id = order_totals.customer_id
GROUP BY c.customer_id, c.name
ORDER BY average_order_value DESC;


-- Query 28: Customers Spending More Than ₹20,000
SELECT
    c.name AS customer_name,
    SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name
HAVING SUM(p.price * oi.quantity) > 20000
ORDER BY total_spent DESC;


-- Query 29: Products Below ₹2,000
-- Your database does not have stock_quantity,
-- so this uses price as a meaningful alternative.
SELECT
    product_name,
    category,
    price
FROM products
WHERE price < 2000
ORDER BY price ASC;


-- Query 30: Order Status Summary
SELECT
    o.status,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(p.price * oi.quantity) AS total_sales
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY o.status
ORDER BY total_sales DESC;


-- Query 31: Products That Have Never Been Ordered
SELECT
    p.product_name,
    p.category
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- Query 32: Products Ordered More Than Once
SELECT
    p.product_name,
    COUNT(oi.order_item_id) AS times_ordered
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(oi.order_item_id) > 1
ORDER BY times_ordered DESC;


-- Query 33: Product Price Analysis with NULLIF
-- Your order_items table has no unit_price or discount.
SELECT
    product_name,
    price,
    NULLIF(price, 0) AS non_zero_price
FROM products;


-- Query 34: Orders Above Average
SELECT
    order_id,
    customer_id,
    order_total
FROM (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(p.price * oi.quantity) AS order_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY
        o.order_id,
        o.customer_id
) AS order_totals
WHERE order_total > (
    SELECT AVG(order_total)
    FROM (
        SELECT
            o.order_id,
            SUM(p.price * oi.quantity) AS order_total
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        JOIN products p
            ON oi.product_id = p.product_id
        GROUP BY o.order_id
    ) AS averages
)
ORDER BY order_total DESC;


-- Query 35: Customer and Product Purchase Details
SELECT
    c.name AS customer_name,
    p.product_name,
    oi.quantity,
    p.price,
    (oi.quantity * p.price) AS purchase_value
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY c.name;