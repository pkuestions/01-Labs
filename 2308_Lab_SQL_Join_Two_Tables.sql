use sakila;

### Q1
### Which actor has appeared in the most films?
SELECT first_name, last_name, count(actor_id)  FROM film_actor JOIN actor USING (actor_id)
GROUP BY actor_id
ORDER BY count(actor_id) DESC
LIMIT 1;

### Q2
### Most active customer (the customer that has rented the most number of films)
SELECT first_name, last_name, count(customer_id) FROM rental JOIN customer USING (customer_id)
GROUP BY customer_id
ORDER BY count(customer_id) DESC
LIMIT 1;

### Q3
### List number of films per category.
SELECT name, count(category_id) FROM film_category JOIN category USING (category_id)
GROUP BY name
ORDER BY name;

### Q4
### Display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address FROM staff JOIN address USING (address_id);

### Q5
### Display the total amount rung up by each staff member in August of 2005.
SELECT first_name, last_name, sum(amount) FROM payment JOIN staff USING (staff_id)
WHERE payment_date BETWEEN 050801 AND 050831
GROUP BY staff_id;

### Q6
### List each film and the number of actors who are listed for that film.
SELECT title, count(DISTINCT actor_id) FROM film_actor AS fac
JOIN (film AS f) USING (film_id)
JOIN (actor AS a) USING (actor_id)
GROUP BY title
ORDER BY count(DISTINCT actor_id) DESC
LIMIT 10;

### Q7
### Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT first_name, last_name, sum(amount) FROM payment JOIN customer USING (customer_id)
GROUP BY customer_id
ORDER BY last_name
LIMIT 10;

### Q8
### Which is the most rented film? The answer is Bucket Brotherhood. This query might require using more than one join statement. Give it a try.
SELECT * FROM inventory;
SELECT title FROM rental
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
GROUP BY film_id
ORDER BY COUNT(DISTINCT rental_id) DESC
LIMIT 1;