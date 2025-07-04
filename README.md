## Task 8 Customer and Orders Project
Customer-Orders SQL Project with Stored Procedure & Function
# Description:
This project uses a simple relational schema (Customers, Orders) to demonstrate real-world SQL tasks like:

Stored procedure with parameters

Custom SQL function

# Tables Used:
Stored Procedure:
CALL GetCustomerOrders(1);

SQL Function:
SELECT name, GetTotalOrders(Cust_id) AS total_orders FROM Customers;
