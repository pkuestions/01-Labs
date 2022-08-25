use sakila;

### 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
SELECT count(inventory_id) AS film_count 
FROM inventory
WHERE film_id IN 
	(SELECT film_id FROM film
	WHERE title = "Hunchback Impossible");

### 2. List all films whose length is longer than the average of all the films.
SELECT title 
FROM film
WHERE length > 
	(SELECT avg(length) FROM film);


### 3. Use subqueries to display all actors who appear in the film _Alone Trip_.
SELECT concat(first_name, " ", last_name) AS actor 
FROM actor
WHERE actor_id IN 	
	(SELECT actor_id FROM film_actor
	WHERE film_id = 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"
		)
	);

### 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title 
FROM film
WHERE film_id IN 
	(SELECT film_id 
    FROM film_category
	WHERE category_id = 
		(SELECT category_id 
        FROM category
		WHERE name = "Family"
        )
	);

### 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
### Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
SELECT first_name, last_name, email 
FROM customer
WHERE address_id IN 
	(SELECT address_id 
    FROM address
	WHERE city_id IN 
		(SELECT city_id 
        FROM city
		WHERE country_id = 
			(SELECT country_id 
            FROM country
			WHERE country = "Canada"
			)
		)
	);

SELECT first_name, last_name, email FROM customer
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
WHERE country = "Canada";

### 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
### First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
SELECT title 
FROM film
WHERE film_id IN 
	(SELECT film_id 
	FROM film_actor
	WHERE actor_id = 
		(SELECT actor_id
		FROM film_actor
		GROUP BY actor_id
		ORDER BY count(film_id) DESC LIMIT 1
        )
	);

### 7. Films rented by most profitable customer. 
### You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select title FROM film
WHERE film_id IN 
	(SELECT film_id 
    FROM inventory
	WHERE inventory_id IN 
		(SELECT inventory_id 
        FROM rental
		WHERE customer_id = 
			(SELECT customer_id 
            FROM payment
			GROUP BY customer_id
			ORDER BY sum(amount) DESC LIMIT 1
            )
		)
	);

### 8. Customers who spent more than the average payments(this refers to the average of all amount spent per each customer).
SELECT first_name, last_name							#--> give customer name of customer_id if customer_id in list of customer_ids below
FROM customer
WHERE customer_id IN 
	(SELECT customer_id 								#--> give list of customer_ids where total amount spent by customer > average of total amount spent by customer
    FROM 												
		(SELECT customer_id, sum(amount) AS s 			# --> give total amount spent by customer (OUTER)
        FROM payment									
		GROUP BY customer_id
        ) AS sub WHERE s > 								#--> filter total spent amount by customer (OUTER) bigger than average of total amount spent by customer (from INNER)
			(SELECT avg(summe) FROM 					#--> give average of total amount spent by customer
				(SELECT sum(amount) AS summe 			#--> give total amount spent by customer (INNER)
                FROM payment							
				GROUP BY customer_id
				) AS sub2
			)
	);

/*
SELECT avg(summe) FROM (
SELECT sum(amount) AS summe FROM payment
GROUP BY customer_id
) AS sub2;

SELECT customer_id, sum(amount) FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC;
*/