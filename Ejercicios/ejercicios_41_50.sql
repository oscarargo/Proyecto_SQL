--41 Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT first_name, COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC
LIMIT 1;


--42 Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT r.rental_id, r.rental_date, c.first_name, c.last_name
FROM rental r
INNER JOIN customer c ON r.customer_id = c.customer_id;


--43 Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id;
--LEFT JOIN (para incluir clientes aunque no tengan alquileres)

--44 Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT f.title, c.name AS categoria
FROM film f
CROSS JOIN category c;
--NO aporta valor práctico directamente, porque hace un producto cartesiano: muestra todas las combinaciones posibles de películas y categorías, aunque no estén relacionadas realmente. Solo sería útil si buscas todas las combinaciones teóricas posibles, pero no representa la realidad del negocio.

--45 Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';


 --46 Encuentra todos los actores que no han participado en películas.
SELECT a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;
--LEFT JOIN + WHERE fa.film_id IS NULL para encontrar aquellos sin relación

 --47 Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_peliculas DESC;

--INNER JOIN (actor – film_actor)Consulta agrupada (GROUP BY)

 --48 Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
CREATE VIEW actor_num_peliculas AS
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

--Se crea una vista para realizar una consulta, esta vista surge de la consulta 47.

 --49 Calcula el número total de alquileres realizados por cada cliente.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_alquileres DESC;


 --50 Calcula la duración total de las películas en la categoría 'Action'.

SELECT SUM(f.length) AS duracion_total
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Action';
