USE sakila; 

#1a
SELECT * FROM actor;

#1b
SELECT CONCAT(first_name, ' ' ,last_name) AS full_name
FROM actor;

#2a
SELECT * FROM sakila.actor WHERE first_name = "Joe";

#2b
SELECT * FROM sakila.actor WHERE last_name LIKE '%GEN%';

#2c
SELECT * FROM sakila.actor WHERE last_name LIKE '%LI%';

#2d
SELECT * FROM sakila.country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
SELECT * FROM actor;

ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_name;

#3b
ALTER TABLE actor
DROP COLUMN description;

#4a
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name; 

#4b
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >= 2; 

#4c
UPDATE actor 
SET first_name = REPLACE (first_name,  'GROUCHO', 'HARPO')
WHERE last_name LIKE '%WILLIAMS%';
 
#4d
UPDATE sakila.actor 
SET first_name = REPLACE (first_name, 'HARPO', 'GROUCHO')
WHERE last_name = '%WILLIAMS%';

#5a
USE sakila; 
SHOW CREATE TABLE Address; 

#6a
SELECT staff.staff_id, staff.first_name, staff.last_name, staff.address_id 
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id;

#6b
SELECT payment.staff_id,  payment_id, payment.amount, payment.payment_date
FROM payment
LEFT JOIN staff ON
payment.staff_id = staff.staff_id;

SELECT staff_id, SUM(amount)
GROUP BY staff_id
HAVING payment_date LIKE '2005'; 

#6c
SELECT title, COUNT(actor_id) AS "Actors"
FROM  film_actor INNER JOIN film ON
film_actor.film_id = film.film_id
GROUP BY title 
ORDER BY Actors DESC;


#6d
USE sakila;
SELECT f.title, COUNT(inventory_id) AS "Number of Copies"
FROM film as f INNER JOIN inventory 
USING(film_id)
WHERE title = 'Hunchback Impossible'
GROUP BY title; 

#6e
SELECT first_name, last_name, SUM(amount) AS "Total Paid"
FROM customer INNER JOIN payment
USING(customer_id)
GROUP BY customer_id;

#7a
SELECT title FROM film
WHERE title LIKE "K%" OR title LIKE"Q%" AND language_id IN 
(SELECT language_id FROM language WHERE name = "English");

#7b
SELECT first_name, last_name FROM actor
WHERE actor_id IN 
(SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id from film WHERE title = "Alone Trip"));

#7c
SELECT first_name, last_name, email, country FROM customer 
INNER JOIN address USING(address_id) 
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id)
WHERE country = "Canada"; 

#7d
SELECT title, name FROM film 
INNER JOIN film_category USING(film_id)
INNER JOIN category USING(category_id)
WHERE name = "Family"; 

#7e
SELECT title, COUNT(title) AS "Rentals"
FROM film 
INNER JOIN inventory USING(film_id)
INNER JOIN  rental USING(inventory_id)
GROUP BY title
ORDER BY Rentals DESC;

#7f
SELECT store_id, film_id, SUM(rental_rate) AS "Store_Total"
FROM store
INNER JOIN inventory USING(store_id)
INNER JOIN film USING(film_id)
GROUP BY store_id
ORDER BY Store_Total;

