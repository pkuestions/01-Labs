use sakila;

# 1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country FROM city
JOIN country USING (country_id)
JOIN address USING (city_id)
JOIN store USING (address_id);

# 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store_id, sum(amount) FROM store
JOIN inventory USING (store_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY store_id;

# 3. What is the average running time(length) of films by category?
SELECT `name`, avg(length) FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
GROUP BY category_id;

# 4. Which film categories are longest(length) (find Top 5)? (Hint: You can rely on question 3 output.)
SELECT `name`, max(length) FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
GROUP BY category_id
LIMIT 5;

# 5. Display the top 5 most frequently(number of times) rented movies in descending order.
SELECT title FROM rental
JOIN payment USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
GROUP BY film_id
ORDER BY COUNT(DISTINCT rental_id) DESC
LIMIT 5;

# 6. List the top five genres in gross revenue in descending order.
SELECT `name`, sum(amount) FROM rental
JOIN payment USING (rental_id)
JOIN inventory USING (inventory_id)
JOIN film_category USING (film_id)
JOIN category USING (category_id)
GROUP BY category_id
ORDER BY sum(amount) DESC
LIMIT 5;

# 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT title, store_id FROM store
JOIN inventory USING (store_id)
JOIN film USING (film_id)
WHERE (title="ACADEMY DINOSAUR" and store_id=1)#
GROUP BY title;