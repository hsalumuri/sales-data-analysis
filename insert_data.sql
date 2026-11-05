PRAGMA foreign_keys = ON;

INSERT INTO customers (customer_id, customer_name, city) VALUES
(1, 'Aarav', 'Bangalore'),
(2, 'Priya', 'Hyderabad'),
(3, 'Rahul', 'Chennai'),
(4, 'Sneha', 'Pune'),
(5, 'Kiran', 'Visakhapatnam'),
(6, 'Ananya', 'Bangalore'),
(7, 'Arjun', 'Hyderabad'),
(8, 'Meera', 'Chennai');

INSERT INTO products (product_id, product_name, category, price) VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mouse', 'Electronics', 800),
(103, 'Keyboard', 'Electronics', 1500),
(104, 'Office Chair', 'Furniture', 6500),
(105, 'Desk', 'Furniture', 9000),
(106, 'Headphones', 'Electronics', 2500),
(107, 'Notebook', 'Stationery', 100),
(108, 'Water Bottle', 'Accessories', 500);

-- Illustrative sample data based on the project practice dataset.
INSERT INTO sales (sale_id, customer_id, product_id, quantity, sale_date) VALUES
(1001, 1, 101, 1, '2026-01-05'),
(1002, 2, 102, 2, '2026-01-06'),
(1003, 3, 104, 1, '2026-01-07'),
(1004, 1, 106, 2, '2026-01-08'),
(1005, 4, 105, 1, '2026-01-10'),
(1006, 5, 103, 1, '2026-01-12'),
(1007, 6, 108, 3, '2026-01-15'),
(1008, 7, 101, 1, '2026-01-18'),
(1009, 8, 107, 5, '2026-01-20'),
(1010, 2, 104, 2, '2026-01-22'),
(1011, 3, 106, 1, '2026-02-02'),
(1012, 5, 102, 3, '2026-02-05'),
(1013, 6, 105, 1, '2026-02-10'),
(1014, 4, 103, 2, '2026-02-15'),
(1015, 7, 108, 2, '2026-02-20');
