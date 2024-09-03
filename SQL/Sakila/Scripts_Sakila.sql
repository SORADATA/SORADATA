-- Analyse des films les plus loués ------

SELECT  f.title, Count(*) AS rental_count
FROM film f 
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY f.film_id
ORDER BY rental_count DESC 
LIMIT 10; 

----- Les clients les plus fidèles 

 SELECT c.customer_id, c.first_name, c.last_name,
COUNT(*) AS rental_count 
  FROM customer c 
  JOIN rental r ON c.customer_id = r.customer_id 
  GROUP BY c.customer_id
  ORDER BY rental_count DESC
  LIMIT 5; 
  
  ----- Le revenu par catégorie de film 
SELECT c.name AS category, SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY total_revenue DESC;

-- Les acteurs les plus populaires 

SELECT a.actor_id, a.first_name, a.last_name, 
COUNT(*) AS film_count 
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id 
ORDER BY film_count DESC 
LIMIT 10; 

-- Les tendances de location par mois 

SELECT date_format(rental_date, "%Y-%m") AS month , 
COUNT(*) AS rental_count 
FROM rental 
GROUP BY month
ORDER BY month; 

-- Les films jamais loués  

SELECT f.film_id, f.title 
FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id 
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE r.rental_id IS NULL; 