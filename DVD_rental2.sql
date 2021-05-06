-- 1.List all customers who live in Texas (use JOINs)
	-- I can't seem to find where the state id is, it's not in 'customer,' 'address,' 'city,' nor 'country'

-- 2.Get all payments above $6.99 with the Customer’s full name
SELECT first_name, last_name, amount, count(*)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount IN (
	SELECT amount
	FROM payment
	WHERE amount > '6.99'
)
GROUP BY amount, first_name, last_name
ORDER BY amount ASC;

-- 3.Show all customer names who have made payments over $175 (use subqueries)
SELECT first_name, last_name, amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount IN (
	SELECT amount
	FROM payment
	WHERE amount > '175'
)
GROUP BY first_name, last_name, amount;

-- 4.List all customers that live in Nepal (use the citytable)
SELECT cus.customer_id, cus.first_name, cus.last_name,  ci.city_id
FROM city as ci
NATURAL JOIN customer as cus
WHERE city_id = '81';

-- 5.Which staff member had the most transactions?
SELECT COUNT(*) FROM payment
WHERE staff_id = '2';
SELECT COUNT(*) FROM payment
WHERE staff_id = '1';

-- 6.What film had the most actors in it?
SELECT title, COUNT(*)
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
WHERE film_actor.film_id IN (
	SELECT film_id
	FROM film
)
GROUP BY title
ORDER BY COUNT(*) DESC;

-- 7. Which actor has been in the least movies?
SELECT first_name, last_name, COUNT(*)
FROM actor
JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_actor.film_id IN (
	SELECT film_id
	FROM film
)
GROUP BY first_name, last_name
ORDER BY COUNT(*) ASC;

-- 8.How many districts have more than 5 customers in it?
SELECT district, COUNT(*)
FROM address
JOIN customer
ON address.address_id = customer.address_id
WHERE address.address_id IN(
-- can't figure out where the 'count>5' part goes... :(
	SELECT address_id
	FROM address
	GROUP BY address_id
)
GROUP BY address.district
ORDER BY COUNT(*) DESC;