-- Write a query to display for each store its store ID, city, and country.
use sakila;
select * from store;

select * from city;
select * from country;
select * from address;

select s.store_id, c.city, co.country from city as c
join country as co 
on c.country_id = co.country_id
join address as a on c.city_id=a.city_id
join store as s on a.address_id=s.address_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.

select * from payment;
select * from customer;

select * from store;  -- commoun colum - address_id


SELECT s.store_id as store, Format (SUM(p.amount), "Currency") AS toat_amount from inventory as i
join rental as r
on i.inventory_id = r.inventory_id
join payment as p
on r.rental_id = p.rental_id
join staff as s
on r.staff_id = s.staff_id
group by s.store_id;



-- 3. Which film categories are longest?

select * from film;

select c.name, sum(length) as max_length from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id=c.category_id
group by c.name
limit 1;

-- 4. Display the most frequently rented movies in descending order.

select * from film;

select title, film_id,rental_rate from film
order by rental_rate DESC;




-- 5.List the top five genres in gross revenue in descending order.

SELECT customer_id, SUM(amount) AS gross_revenue
FROM payment
GROUP BY customer_id
order by gross_revenue DESC
LIMIT 5 ;


-- 6. Is "Academy Dinosaur" available for rent from Store 1?

select f.film_id, f.title, s.store_id, i.inventory_id from inventory as i
join store as s on i.store_id=s.store_id
join film as f on i.film_id=f.film_id
where f.title = 'Academy Dinosaur' and s.store_id = 1;


-- 7. Get all pairs of actors that worked together.

select * from film_actor;
select * from actor;

SELECT a1.first_name as 1_actor_name, f1.actor_id as 1_actor_id, a2.first_name as 2_actor_name, f2.actor_id as 2_actor_id, f1.film_id as worked_together_in_this_film
FROM film_actor AS f1
JOIN film_actor AS f2
ON f1.film_id = f2.film_id
JOIN actor AS a1
ON f1.actor_id = a1.actor_id
JOIN actor AS a2
ON f2.actor_id = a2.actor_id
WHERE f1.actor_id <> f2.actor_id;

-- to test
SELECT f1.actor_id, f2.actor_id, f1.film_id
FROM film_actor AS f1
JOIN film_actor AS f2
WHERE f1.actor_id <> f2.actor_id;


-- 8. Get all pairs of customers that have rented the same film more than 3 times.

select * from rental;
select * from customer;
select * from film;
select * from film_actor;
-- customer_id
-- rental_id 

select c1.customer_id, c2.customer_id, r1.rental_id, r2.rental_id
FROM rental AS r1
JOIN rental AS r2 ON r1.inventory_id = r2.inventory_id
join customer as c1 on r1.customer_id = c1.customer_id
join customer as c2 on r2.customer_id = c2.customer_id;


-- 9. For each film, list actor that has acted in more films.

select * from actor;
select * from film_actor;

select a.actor_id, a.first_name, a.last_name,
count(a.actor_id) as film_count from actor as a 
join film_actor as f on a.actor_id= f.actor_id
group by a.actor_id
order by film_count desc;

