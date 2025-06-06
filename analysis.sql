-- Show all customers
SELECT * FROM customers;

-- Show customers from India
SELECT * FROM customers WHERE country = 'India';

-- Join customers and orders
SELECT c.name, o.order_date, o.amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- Count customers per country
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country;

-- Customers who placed orders over 500
SELECT name FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders WHERE amount > 500
);

-- Drop view if exists before creating (to avoid errors on re-run)
DROP VIEW IF EXISTS high_value_customers;

-- Create view for high-value customers
CREATE VIEW high_value_customers AS
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 1000;

-- Drop index if exists before creating
DROP INDEX IF EXISTS idx_customer_id;

-- Create index on customer_id in orders
CREATE INDEX idx_customer_id ON orders(customer_id);
