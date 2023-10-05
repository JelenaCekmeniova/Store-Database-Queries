USE store;

#Task1
#Q1.1
SELECT *
FROM customers
ORDER BY first_name;

#Q1.2
SELECT last_name, first_name, points, points + 10
FROM customers;

#Q1.3
SELECT last_name, first_name, points, 
(points + 10)*100 AS 'discount_factor'
FROM customers;

#Task2
#Q2.1
SELECT name, unit_price, unit_price * 1.1 AS 'new price'
FROM products;

#Task3
#Q3.1
SELECT * FROM customers
WHERE birth_date > '1990-01-01';


#Task4 - Additional Queries
#Q4.1 - concatenation
SELECT CONCAT(last_name, ', ', first_name) AS 'Name',
phone AS 'Phone',
CONCAT(address, ', ', city, ', ', state) AS 'Address'
FROM customers
WHERE phone LIKE '7%'
ORDER BY last_name;

#Q4.2 - distinct values
SELECT DISTINCT COUNT(state) FROM customers; 
# returns 10

SELECT COUNT(*) FROM products;
#returns 10

SELECT DISTINCT COUNT(name) FROM products;
#also returns 10

#Q4.3 - sum, average, min, max
SELECT name, quantity_in_stock AS 'quantity',
unit_price AS 'sales price',
(quantity_in_stock * unit_price) AS 'revenue per product'
FROM products;

SELECT SUM(quantity_in_stock * unit_price) AS 'Total Revenue'
FROM products;

SELECT AVG(quantity_in_stock * unit_price) AS 'Average Revenue per Product',
       MIN(quantity_in_stock * unit_price) AS 'Minumum Revenue per Product',
       MAX(quantity_in_stock * unit_price) AS 'Maximum Revenue per Product'
FROM products;

#Q4.4 - grouping by
SELECT COUNT(customer_id) FROM orders;
#returns 10 orders altogether

SELECT customer_id, COUNT(*) FROM orders
GROUP BY customer_id;
#returns how many orders per customer with specific ID

#Q4.5 - comparison
SELECT * FROM order_statuses
WHERE name != 'shipped';

SELECT customer_id, COUNT(*) AS 'number of orders'
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY customer_id;

#Q4.6 - case statement
SELECT first_name, last_name, points,
CASE
	WHEN points < 1000 THEN 'Loyalty Level 1'
    WHEN points BETWEEN 1000 AND 1999 THEN 'Loyalty Level 2'
    ELSE 'Loyalty Level 3'
END AS 'Loyalty Level'
FROM customers;

#Q4.7 - Join
SELECT order_id, first_name, last_name, address, order_date, 
IFNULL(shipped_date,'Missing') AS "Shipping_Date", status 
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id
WHERE status = 2
ORDER BY order_id ASC;


/* Task 5 - EER Diagram - Identifying Primary and Foreign Keys
Primary Key (PK), Foreign Key (FK), Composite Key (CK)
'customers' table: 'customer_id' - PK;	
‘orders’ table: ‘order_id’ - PK, ‘customer_id’ and ‘status’ – FKs;
‘order_statuses’ table: ‘order_status_id’ – PK;
‘shippers’ table: ‘shipper_id’ – PK;
‘products’ table: ‘product_id’ – PK;
‘order_items’ table – ‘order_id’ and ‘product_id’ – Composite Keys (CKs) 
*/
