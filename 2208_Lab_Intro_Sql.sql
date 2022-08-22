use sakila;

# select * from actor;

### Explore tables by selecting all columns from each table or using the in built review features for your client.
select * from actor; # 4 cols
select * from address; # 9 cols
select * from category; # 3 cols
select * from city; # 4 cols
select * from country; # 3 cols
select * from customer; # 9 cols
select * from film; # 13 cols
select * from film_actor; # 3 cols
select * from film_category; # 3 cols
select * from film_text; # 3 cols
select * from inventory; # 4 cols
select * from language; # 3 cols
select * from payment; # 7 cols
select * from rental; # 7 cols
select * from staff; # 11 cols
select * from store; # 4 cols 

### Select one column from a table. Get film titles.
select title from film;

### Select one column from a table and alias it.
select title as tits from film;

### Get unique list of film languages under the alias language. 
select distinct (name) as language from language;
### Note that we are not asking you to obtain the language per each film, 
### but this is a good time to think about how you might get that information in the future.

### Find out how many stores does the company have?
select count(store_id) from store;

### Find out how many employees staff does the company have?
select count(staff_id) from staff;

### Return a list of employee first names only
select first_name from staff;