--21 ¿Cuál es la media de duración del alquiler de las películas? 
SELECT AVG(rental_duration) AS media_duracion_alquiler
FROM film;

--22  Crea una columna con el nombre y apellidos de todos los actores y  actrices.
SELECT actor_id, first_name || ' ' || last_name AS nombre_completo
FROM actor;
-- Se usa la concatenación || para crear una sola columna con nombre completo.

--23 Números de alquiler por día, ordenados por cantidad de alquiler de  forma descendente.
SELECT rental_date::date AS dia, COUNT(*) AS total_alquileres
FROM rental
GROUP BY rental_date::date
ORDER BY total_alquileres DESC;

--24  Encuentra las películas con una duración superior al promedio.
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) 
                FROM film)
;
-- EN este caso hacemos una subconsulta dentro del término where para comparar con una media
--25  Averigua el número de alquileres registrados por mes
SELECT DATE_TRUNC('month', rental_date) AS mes, COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE_TRUNC('month', rental_date)
ORDER BY mes;

--26Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT 
  AVG(amount) AS promedio_total_pagado,
  STDDEV(amount) AS desviacion_estandar,
  VARIANCE(amount) AS varianza
FROM payment;

--27¿Qué películas se alquilan por encima del precio medio?
SELECT DISTINCT f.title, f.rental_rate
FROM film f
WHERE f.rental_rate > (SELECT AVG(rental_rate) FROM film);
-- subconsulta en WHere
--28 Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT actor_id, COUNT(film_id) AS total_peliculas
FROM film_actor
GROUP BY actor_id
HAVING COUNT(film_id) > 40;

--29 Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT f.title, COUNT(i.inventory_id) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;

--30 Obtener los actores y el número de películas en las que ha actuado.

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_peliculas
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_peliculas DESC;
