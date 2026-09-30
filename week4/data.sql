USE ecommerce_db;

-- Customers
INSERT INTO customers (name, email, city) VALUES
('Rahul Sharma', 'rahul.sharma@gmail.com', 'Bengaluru'),
('Priya Patel', 'priya.patel@gmail.com', 'Mumbai'),
('Arjun Kumar', 'arjun.kumar@gmail.com', 'Delhi'),
('Sneha Reddy', 'sneha.reddy@gmail.com', 'Hyderabad'),
('Vikram Singh', 'vikram.singh@gmail.com', 'Chennai'),
('Ananya Iyer', 'ananya.iyer@gmail.com', 'Pune'),
('Rohan Mehta', 'rohan.mehta@gmail.com', 'Ahmedabad'),
('Kavya Nair', 'kavya.nair@gmail.com', 'Kochi'),
('Aditya Joshi', 'aditya.joshi@gmail.com', 'Jaipur'),
('Neha Verma', 'neha.verma@gmail.com', 'Kolkata');

-- Products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 65000.00),
('Wireless Mouse', 'Electronics', 1200.00),
('Mechanical Keyboard', 'Electronics', 4500.00),
('Smartphone', 'Electronics', 30000.00),
('Headphones', 'Electronics', 2500.00),
('Running Shoes', 'Footwear', 3500.00),
('Backpack', 'Accessories', 1800.00),
('Smart Watch', 'Electronics', 8000.00),
('T-Shirt', 'Clothing', 999.00),
('Water Bottle', 'Accessories', 700.00);

-- Orders
INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2026-09-01', 'Delivered'),
(2, '2026-09-02', 'Delivered'),
(3, '2026-09-03', 'Shipped'),
(4, '2026-09-05', 'Delivered'),
(5, '2026-09-07', 'Processing'),
(6, '2026-09-10', 'Delivered'),
(7, '2026-09-12', 'Shipped'),
(8, '2026-09-15', 'Delivered'),
(9, '2026-09-18', 'Processing'),
(10, '2026-09-20', 'Delivered'),
(1, '2026-09-22', 'Shipped'),
(3, '2026-09-23', 'Delivered'),
(5, '2026-09-25', 'Processing'),
(7, '2026-09-27', 'Delivered'),
(9, '2026-09-29', 'Shipped');

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 4, 1),
(2, 5, 1),
(3, 3, 1),
(3, 7, 1),
(4, 6, 2),
(4, 10, 2),
(5, 8, 1),
(5, 5, 1),
(6, 1, 1),
(6, 7, 1),
(7, 9, 3),
(7, 10, 2),
(8, 4, 1),
(8, 2, 1),
(9, 6, 1),
(9, 8, 1),
(10, 3, 1),
(10, 5, 2),
(11, 2, 1),
(11, 9, 2),
(12, 1, 1),
(12, 10, 1),
(13, 4, 1),
(13, 7, 1),
(14, 6, 1),
(14, 5, 1),
(15, 8, 1);