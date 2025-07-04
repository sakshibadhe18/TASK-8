CREATE DATABASE cust; 
USE cust;

# 1st table is Customers 
 CREATE TABLE Customers(
 Cust_id INT PRIMARY KEY,
 Name VARCHAR(50),
 City VARCHAR (50)
 );
INSERT INTO Customers (Cust_id, name, city) VALUES (1, 'Sakshi', 'Mumbai'),(2, 'Rohit', 'Pune'),(3, 'Priya', 'Nagpur'),(4, 'Aditya', 'Thane'),(5, 'Sneha', 'Nashik'),
(6, 'Amit', 'Pune'), (7, 'Meera', 'Solapur'), (8, 'Rahul', 'Pune'),(9, 'Kiran', 'Kolhapur'),(10, 'Deepa', 'Mumbai'), (11, 'Manish', 'Navi Mumbai'),(12, 'Neha', 'Aurangabad'),
(13, 'Varun', 'Nagpur'),(14, 'Isha', 'Nashik'),(15, 'Sameer', 'Thane');
SELECT * FROM Customers;

 # 2nd table is Orders 
 CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    Cust_id INT,
    product VARCHAR(50),
    amount INT,
    FOREIGN KEY (Cust_id) REFERENCES Customers(Cust_id));
INSERT INTO Orders (order_id, Cust_id, product, amount)
VALUES 
(101, 1, 'Laptop', 55000),
(102, 2, 'Mobile', 20000),
(103, 1, 'Keyboard', 1500),
(104, 3, 'Monitor', 7000),
(105, 7, 'Mouse', 500),      
(106, 2, 'Charger', 800),
(107, 4, 'Tablet', 15000),
(108, 8, 'Printer', 6000),    
(109, 1, 'USB Cable', 300),
(208, 8, 'Printer', 6000),    
(209, 10, 'Speaker', 2500), 
(210, 11, 'Charger', 900),    
(211, 15, 'Hard Disk', 4500), 
(212, 12, 'Webcam', 2200),    
(213, 5, 'Power Bank', 1200),
(214, 14, 'SSD', 5000),        
(215, 13, 'Stylus Pen', 1500); 

SELECT * FROM Orders;

# JOIN
SELECT Orders.Cust_id ,Name,City
FROM Customers
INNER JOIN Orders
ON Customers.Cust_id = Orders.Cust_id;

SELECT Orders.Cust_id, Customers.name, Orders.product, Orders.amount
FROM Customers
JOIN Orders ON Customers.Cust_id = Orders.Cust_id;

SELECT Orders.Cust_id, Customers.name, Orders.product, Orders.amount
FROM Customers
 RIGHT JOIN Orders ON Customers.Cust_id = Orders.Cust_id;

SELECT 
    c.Cust_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.product,
    o.amount
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Cust_id = o.Cust_id

UNION

SELECT 
    c.Cust_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.product,
    o.amount
FROM 
    Customers c
RIGHT JOIN 
    Orders o ON c.Cust_id = o.Cust_id;

SELECT 
    c.Cust_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.product,
    o.amount
FROM 
    Customers c
RIGHT JOIN 
    Orders o ON c.Cust_id = o.Cust_id;

SELECT 
    c.Cust_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.product,
    o.amount
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Cust_id = o.Cust_id;

SELECT 
    c.Cust_id,
    c.name AS customer_name,
    c.city,
    o.order_id,
    o.product,
    o.amount
FROM 
    customers c
INNER JOIN 
    Orders o ON c.Cust_id = o.Cust_id;

# Subquery
 # Find customers  who placed orders above the average order amount
SELECT name, city
FROM Customers
WHERE Cust_id IN (
    SELECT Cust_id
    FROM Orders
    WHERE amount > (
        SELECT AVG(amount) FROM Orders
    )
);

# List all customers and show total orders they placed
SELECT 
    c.name,
    c.city,
    (SELECT COUNT(*) 
     FROM Orders o 
     WHERE o.Cust_id = c.Cust_id) AS total_orders
FROM Customers c;

# Find customers who placed at least one order
SELECT name, city
FROM Customers
WHERE Cust_id IN (
    SELECT DISTINCT Cust_id
    FROM Orders
);

# Show customers who have orders
SELECT name, city
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.Cust_id = c.Cust_id
);

#  Get customers from the same city as 'Rohit'
SELECT name, city
FROM Customers
WHERE city = (
    SELECT city FROM Customers WHERE name = 'Rohit'
);

# Create a view
CREATE VIEW Customer_Order_Summary AS
SELECT 
    c.Cust_id,
    c.name AS customer_name,
    c.city,
    COUNT(o.order_id) AS total_orders,
    IFNULL(SUM(o.amount), 0) AS total_amount
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Cust_id = o.Cust_id
GROUP BY 
    c.Cust_id, c.name, c.city;

SELECT * FROM Customer_Order_Summary;

# Create a view showing only non-sensitive customer data
CREATE VIEW Customer_Public_View AS
SELECT 
    name,
    city
FROM 
    Customers;

SELECT * FROM Customer_Public_View;

CREATE VIEW High_Value_Orders AS
SELECT 
    order_id,
    Cust_id,
    product,
    amount
FROM 
    Orders
WHERE 
    amount > 10000;

SELECT * FROM High_Value_Orders;

DROP VIEW High_Value_Orders;

CALL GetCustomerOrders(1);

SELECT name, GetTotalOrders(Cust_id) AS total_orders
FROM Customers;
