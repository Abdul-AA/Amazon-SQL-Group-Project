
Query 1: View List of Customers that Bought an Ipad Air

SELECT c.customer_first_name, c.customer_last_name, p.product_name 
FROM Customers c 
JOIN Orders o ON c.customerID = o.customerID 
JOIN OrderItems oi ON o.orderID = oi.orderID
JOIN Products p ON p.productID = oi.productID
WHERE p.product_name='Ipad Air';

Query 2: Average Order Value Last Month

SELECT ROUND (AVG(order_total), 2) AS avg_order_value_last_month
FROM (SELECT o.orderID, SUM(p.product_price * oi.quantity_ordered) AS order_total
FROM Orders o JOIN OrderItems oi ON o.orderID = oi.orderID
JOIN Products p ON oi.productID = p.productID
WHERE DATEDIFF(CURRENT_DATE, o.order_date) <= 30
GROUP BY o.orderID) AS subquery;

Query 3: Vendor and their Ratings

SELECT p.vendorID, v.vendor_name, AVG(r.rating) AS avg_rating
FROM Products p
JOIN Vendors v ON p.vendorID = v.vendorID
LEFT JOIN Reviews r ON p.productID = r.productID
GROUP BY p.vendorID, v.vendor_name;
 
Query 4: Products without Reviews in the Last 6 Months

SELECT productID, product_name
FROM Products WHERE productID NOT IN (
SELECT productID FROM Reviews 
WHERE DATEDIFF(CURRENT_DATE, review_date) <= 180);

Query 5: Total Sales by Province

SELECT c.state, SUM(p.product_price * oi.quantity_ordered) AS total_sales
FROM Customers c
JOIN Orders o ON c.customerID = o.customerID
JOIN OrderItems oi ON o.orderID = oi.orderID
JOIN Products p ON oi.productID = p.productID
GROUP BY c.state;

Query 6: Products not in any Shopping Cart

SELECT productID, product_name
FROM Products
WHERE productID NOT IN (SELECT DISTINCT productID FROM ShoppingCartItems);

Query 7: Top 3 vendors by product sales

SELECT p.vendorID, v.vendor_name, SUM(oi.quantity_ordered) AS total_products_sold
FROM Products p JOIN Vendors v ON p.vendorID = v.vendorID
JOIN OrderItems oi ON p.productID = oi.productID
GROUP BY p.vendorID, v.vendor_name
ORDER BY total_products_sold DESC
LIMIT 3;

Query 8: Total Products in Customer Cart

SELECT sc.customerID, COUNT(sci.productID) AS total_products
FROM ShoppingCart sc
JOIN ShoppingCartItems sci ON sc.shoppingcartID = sci.shoppingcartID
GROUP BY sc.customerID;

Query 9: Customers Spending over $1000

SELECT o.customerID, SUM(p.product_price * oi.quantity_ordered) AS total_spent
FROM Orders o
JOIN OrderItems oi ON o.orderID = oi.orderID
JOIN Products p ON oi.productID = p.productID
GROUP BY o.customerID
HAVING total_spent > 1000;
 
Query 10: Customers with only one order 

SELECT c.customerID, customer_first_name, customer_last_name, COUNT(orderID) AS 
total_orders
FROM Orders AS o
INNER JOIN Customers AS c
ON c.customerID=o.customerID
GROUP BY customerID
HAVING total_orders = 1;

Query 11: Most Popular Product by Sales

SELECT p.productID, p.product_name, SUM(quantity_ordered) AS total_ordered
FROM OrderItems
INNER JOIN Products AS p ON p.productID=OrderItems.productID
GROUP BY p.productID, product_name
ORDER BY total_ordered DESC
LIMIT 1;

Query 12: Total Sales by Vendor

SELECT v.vendorID, v.vendor_name, SUM(p.product_price * oi.quantity_ordered) AS 
total_sales
FROM Vendors v
JOIN Products p ON v.vendorID = p.vendorID
JOIN OrderItems oi ON p.productID = oi.productID
GROUP BY v.vendorID;

Query 13: Top Rated Products with Ratings greater than 4.5

SELECT p.productID, product_name, AVG(rating) AS avg_rating
FROM Reviews AS r 
INNER JOIN Products AS p 
ON p.productID = r.productID
GROUP BY productID
HAVING avg_rating > 4.5;

Query 14: Customers who has not made a purchase in the Last 30 Days

SELECT c.customerID, customer_first_name
FROM Orders as o 
INNER JOIN Customers AS c
ON c.customerID = o.customerID
WHERE DATEDIFF(CURRENT_DATE, order_date) > 30;

Query 15: Top 2 Customers with Most Number of Orders

SELECT c.customerID, customer_first_name, COUNT(orderID) AS total_orders
FROM Orders o 
INNER JOIN Customers c 
ON c.customerID = o.customerID
GROUP BY customerID
ORDER BY total_orders DESC
LIMIT 2;

Query 16: Customers that live around Sherbrooke and has made an Order

SELECT customer_first_name, address_line FROM Customers 
WHERE customerID in (SELECT customerID FROM Orders) 
AND address_line LIKE '%Sherbrooke%';

Query 17: Customer Order Subtotals

SELECT c.customerID, c.customer_first_name, c.customer_last_name, 
SUM(oi.quantity_ordered * p.product_price) AS order_subtotal
FROM Customers c
JOIN Orders o ON c.customerID = o.customerID
JOIN OrderItems oi ON o.orderID = oi.orderID
JOIN Products p ON oi.productID = p.productID
GROUP BY c.customerID;

Query 18: Average Number of Items in Shopping Cart for each Customer

SELECT c.customer_first_name, c.customer_last_name, AVG(sci.quantity_in_cart) AS 
avg_products_in_cart
FROM Customers c
LEFT JOIN ShoppingCart sc ON c.customerID = sc.customerID
LEFT JOIN ShoppingCartItems sci ON sc.shoppingcartID = sci.shoppingcartID
GROUP BY c.customerID
ORDER BY avg_products_in_cart DESC;

Query 19: View Orders that are still ÔProcessingÕ

SELECT o.orderID, c.customer_first_name, c.customer_last_name, o.order_date, 
o.shipping_date, o.status
FROM Orders o
JOIN Customers c ON o.customerID = c.customerID
WHERE o.status = 'Processing';

Query 20: Average Number of Days between Order Date and Shipping Date

SELECT ROUND(AVG(DATEDIFF(shipping_date, order_date))) AS avg_days_to_ship
FROM Orders
WHERE status = 'Shipped';
