-- QUESTION 1
select * from address
select * from staff
select * from city

Select s.store_id,s.first_name, s.last_name, s.email, a.address, a.district, c.city
from staff s
join address a
on s.address_id = a.address_id
join city c
on a.city_id = c.city_id

-- QUESTION 2
Select *
from film

Select store_id, count(*)
from inventory
group by store_id

SELECT  i.inventory_id, i.store_id, f.title, f.release_year, f.rating, f.replacement_cost, f.rental_rate
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id

-- QUESTION 3

SELECT  Distinct rating, count(rating)  as inventory_total, store_id as store
FROM
(SELECT  i.inventory_id, i.store_id, f.title, f.release_year, f.rating, f.replacement_cost, f.rental_rate
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id) as p
GROUP BY rating, store_id 
order by store_id asc

-- QUESTION 4


SELECT   f.title, f.release_year, f.rating, f.replacement_cost, f.rental_rate, c.name as film_category
FROM film f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id

-- To answer the question based on film category
WITH CTE as 
(SELECT  f.title, f.release_year, f.rating, f.replacement_cost, f.rental_rate, c.name as film_category
FROM film f
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id
)

select  film_category as film_category,
 avg(replacement_cost) as avg_cost, Sum(replacement_cost) as total_cost
from cte 
group by film_category


-- based on store location
WITH CTE_2 AS (SELECT   i.store_id, f.replacement_cost, f.rental_rate
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id)

SELECT  store_id, avg(replacement_cost) as avg_cost, Sum(replacement_cost) as total_cost
from CTE_2
group by  store_id

-- QUESTION 5

select customer.store_id, customer.first_name, customer.last_name, customer.active, 
address.address,city.city, address.district as country
from customer
join address
on customer.address_id = address.address_id
join city
on address.city_id = city.city_id

-- QUESTION 6

WITH new AS (
    SELECT
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_amount,
        COUNT(p.rental_id) AS total_lifetimerentals
    FROM payment p
    JOIN customer c ON p.customer_id = c.customer_id
	GROUP BY c.first_name, c.last_name, p.customer_id
)
SELECT
    first_name,
    last_name,
    total_amount,
    total_lifetimerentals
FROM new
ORDER BY first_name, last_name;


-- QUESTION 7
select concat( a.first_name, ' ', a.last_name) as advisor_name,  concat (i.first_name, ' ',i.last_name) as investor_name, 
i.company_name as investor_comapay
from advisor a
cross join investor i


