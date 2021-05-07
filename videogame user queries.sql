
USE videogame;
#----------------------------CUSOMER QUERIES--------------------------------------

# Returns product listings sorted by price from lowest to highest.

SELECT *
FROM Products 
ORDER BY unit_price;
#--------------------------------------------------------------------------------

# Returns products that are for the Nintendo Switch.

SELECT *
FROM Products
WHERE platform_id IN
	(SELECT platform_id
	 FROM platform
     WHERE platform_name = 'Nintendo Switch');
#--------------------------------------------------------------------------------

# Returns products that are either sport or adventure games.

SELECT *
FROM Products
WHERE genre_id IN
	(SELECT genre_id
	 FROM genre
     WHERE genre_name IN ('Sport', 'Adventure'));
#--------------------------------------------------------------------------------

# Returns the product that has the most recent release date (newest game currentlty being offered).

SELECT *
FROM products
WHERE release_date IN
	(SELECT MAX(release_date)
	 FROM products);

#--------------------------------------------------------------------------------

# For customers to see their transation history from their account profile (Example: Customer 1)

SELECT p.product_name AS `Game Title`, od.quantity AS `Quantity`, ROUND(p.unit_price*od.quantity, 2) AS `Subtotal`, ROUND(p.unit_price*od.quantity*1.13, 2) AS `Total`, o.order_date AS `Date order placed`
FROM order_details od 
	JOIN products p
		ON p.product_id = od.product_id
	JOIN orders o
		ON o.order_id = od.order_id
WHERE customer_id = 1
ORDER BY o.order_date;
#--------------------------------------------------------------------------------

# Returns tracking summary for a given order using the provided tracking order_id. 

SELECT *
FROM order_track
WHERE order_id = 1;

#-----------------------------MANAGER QUERIES------------------------------------

# Returns a report that managers can use to monitor product stock.

SELECT p.product_id, p.product_name, p.stock AS `Original Stock`, SUM(od.quantity) AS `Units Sold`, (p.stock - SUM(od.quantity)) AS `Available Stock`, IF((p.stock - SUM(od.quantity)) > 0, "In stock", "Out of stock") AS `Status`
FROM products p
	JOIN order_details od
		ON p.product_id = od.product_id
GROUP BY p.product_id;

# Returns a report that generates product list by platform

SELECT p.product_id, p.product_name, pl.platform_name
FROM products p 
	JOIN platform pl
		ON p.platform_id = pl.platform_id
ORDER BY platform_name DESC;

# Returns a customer list that grouped by customers within Ontario and customers outside of Ontario.

	SELECT "Within Ontario" as Province_type, last_name, first_name, address_1, address_2, email, phone
	FROM customer 
	WHERE province = "Ontario"
UNION
	SELECT "Outside of Ontario" as Province_type, last_name, first_name, address_1, address_2, email, phone
	FROM customer
	WHERE province != "Ontario";

# Report that identifies how many games each registered customer has purchased and their all time gross sales total.

SELECT c.customer_id, c.last_name, c.first_name, SUM(od.quantity) AS `Total Units Purchased`, SUM(ROUND(p.unit_price*od.quantity, 2)) AS `Gross Sales`
FROM customer c
	JOIN orders o
		ON c.customer_id = o.customer_id
	JOIN order_details od
		ON o.order_id = od.order_id
	JOIN products p
		ON od.product_id  = p.product_id
GROUP BY c.customer_id;

# Creates a view detailing which platforms are the most popular in terms of sales.

CREATE VIEW sales_by_platform AS
SELECT pl.platform_name, SUM(od.quantity) AS `Games Sold`, SUM(ROUND(p.unit_price*od.quantity, 2)) AS `Gross Sales`
FROM platform pl
	JOIN products p
		ON pl.platform_id = p.platform_id
	JOIN order_details od
		ON p.product_id = od.product_id
GROUP BY platform_name;

# Returns which orders have been delivered.

SELECT order_id, order_status, date
FROM order_track
WHERE order_status = "delivered"
ORDER BY order_id; 