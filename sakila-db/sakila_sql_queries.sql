-- SAKILA SQL PRACTICE QUERIES  

USE sakila; 

-- 1 View all films (first 10) 
-- Preview the film table to understand available columns 
SELECT 
* 
FROM 
film LIMIT 10; 

-- 2. List all customers from Canada 
-- Retrieve all customers who live in Canada by joining related address, city, and country tables 
SELECT 
c.first_name, 
c.last_name 
FROM 
customer AS c 
JOIN 
address AS a ON c.address_id = a.address_id 
JOIN 
city AS ci ON a.city_id = ci.city_id 
JOIN 
country AS co ON ci.country_id = co.country_id 
WHERE 
co.country = 'Canada'; 

-- 3. Top 5 most rented films 
-- Find which films were rented the most times 
SELECT 
f.title, 
COUNT(r.rental_id) AS total_rentals 
FROM 
rental AS r 
JOIN 
inventory AS i ON r.inventory_id = i.inventory_id 
JOIN 
film AS f ON i.film_id = f.film_id 
GROUP BY
 f.title 
ORDER BY 
total_rentals DESC LIMIT 5; 

-- 4. Total revenue per store 
-- Calculate total payment amount received by each store 
SELECT 
s.store_id, 
SUM(p.amount) AS total_revenue 
FROM 
store AS s 
JOIN 
staff AS st ON s.store_id = st.store_id 
JOIN 
payment AS p ON st.staff_id = p.staff_id 
GROUP BY 
s.store_id 
ORDER BY 
total_revenue DESC; 

-- 5. Customer who spent the most 
-- Identify the top customer based on total amount spent 
SELECT 
c.first_name, 
c.last_name, 
SUM(p.amount) AS total_spent 
FROM 
customer AS c 
JOIN 
payment AS p ON c.customer_id = p.customer_id 
GROUP BY 
c.customer_id 
ORDER BY 
total_spent DESC LIMIT 1; 

-- 6. Number of rentals per month 
-- Count how many rentals happened each month 
SELECT 
DATE_FORMAT(rental_date, '%Y-%m') AS rental_month, 
COUNT(*) AS total_rentals 
FROM 
rental 
GROUP BY 
rental_month 
ORDER BY
 rental_month; 

-- 7. Count of films per category 
-- Find how many films belong to each genre/category 
SELECT 
c.name AS category_name, 
COUNT(f.film_id) AS total_films 
FROM 
film AS f 
JOIN 
film_category AS fc ON f.film_id = fc.film_id 
JOIN 
category AS c ON fc.category_id = c.category_id 
GROUP BY
 c.name 
ORDER BY 
total_films DESC; 

-- 8. Average rental duration per category
 -- Determine which film categories have the longest average rental duration 
SELECT 
c.name AS category_name, 
AVG(f.rental_duration) AS avg_duration 
FROM 
film AS f 
JOIN 
film_category AS fc ON f.film_id = fc.film_id 
JOIN 
category AS c ON fc.category_id = c.category_id 
GROUP BY 
c.name 
ORDER BY 
avg_duration DESC; 

-- 9. Staff performance: total payments processed 
-- Measure how much payment each staff member handled 
SELECT 
s.first_name,
s.last_name,
SUM(p.amount) AS total_sales 
FROM 
staff AS s 
JOIN 
payment AS p ON s.staff_id = p.staff_id 
GROUP BY 
s.staff_id 
ORDER BY 
total_sales DESC; 

-- 10. Active vs inactive customers 
-- Show the number of active and inactive customers
 SELECT 
CASE WHEN active = 1 THEN 'Active' ELSE 'Inactive' END AS customer_status, 
COUNT(*) AS customer_count 
FROM 
customer 
GROUP BY 
customer_status; 