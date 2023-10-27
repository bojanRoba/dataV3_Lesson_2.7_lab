USE sakila;

SELECT * FROM sakila.film;
SELECT * FROM sakila.film_category;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT c.category_id, COUNT(title) as title_total
FROM sakila.film_category as c
JOIN sakila.film as f
ON f.film_id = c.film_id
GROUP BY c.category_id
ORDER BY c.category_id ASC;

-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT SUM(amount) as total_amount, date(payment_date), s.first_name, s.last_name
FROM sakila.payment as p
JOIN sakila.staff as s
on p.staff_id = s.staff_id
WHERE EXTRACT(YEAR FROM payment_date) = 2005 AND EXTRACT(MONTH FROM payment_date) = 08 
GROUP BY date(payment_date), first_name, last_name
ORDER BY date(payment_date);

SELECT staff_id, SUM(amount) AS rung_up_amount, DATE_FORMAT(payment_date, '%M %Y') AS 'month_and_year'
FROM payment
WHERE EXTRACT(YEAR FROM payment_date) = 2005
AND EXTRACT(MONTH FROM payment_date) = 8
GROUP BY staff_id;

-- 3. Which actor has appeared in the most films?

SELECT * FROM sakila.film;
SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.actor;

SELECT *
FROM sakila.film
JOIN sakila.film_actor USING (film_id)
JOIN sakila.actor USING (actor_id)
ORDER BY sakila.film.title;

SELECT ac.actor_id, ac.first_name, ac.last_name, COUNT(fa.actor_id) AS 'film_count'
FROM sakila.actor AS ac
JOIN sakila.film_actor AS fa
ON ac.actor_id = fa.actor_id
GROUP BY ac.actor_id, ac.first_name, ac.last_name
ORDER BY film_count DESC
LIMIT 10;

-- 4. Most active customer (the customer that has rented the most number of films)

SELECT first_name, last_name, COUNT(rental_id) as rental_num
FROM customer AS c
JOIN rental AS r
USING (customer_id)
GROUP BY first_name, last_name
ORDER BY rental_num DESC
LIMIT 10;

-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT CONCAT(first_name," ",last_name) as staff_member, address.address
FROM staff
JOIN address USING (address_id);

-- 6. List each film and the number of actors who are listed for that film.

SELECT title, COUNT(actor_id) as num_actors
FROM film
LEFT JOIN film_actor USING (film_id)
GROUP BY film.title 
ORDER BY num_actors DESC;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT CONCAT(last_name," ",first_name) as customer, SUM(amount) as total_amount
FROM payment JOIN customer USING (customer_id)
GROUP BY customer ORDER BY customer;

-- 8. List the titles of films per category.

SELECT film.title, category.name
FROM film 
JOIN film_category USING (film_id)
JOIN category USING (category_id);
