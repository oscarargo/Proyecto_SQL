--31 Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT f.title, a.first_name, a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY f.title;
--LEFT JOIN (porque queremos ver todas las películas, incluso si no tienen actores) Ordenamos por título para que se vea mejor.

--32 Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT a.first_name, a.last_name, f.title
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON fa.film_id = f.film_id
ORDER BY a.last_name, a.first_name;
--LEFT JOIN (porque queremos ver todos los actores, aunque no tengan películas) Ordenamos por apellido y nombre.

--33 Obtener todas las películas que tenemos y todos los registros de  alquiler.

SELECT f.title, r.rental_id, r.rental_date
FROM film f
FULL JOIN inventory i ON f.film_id = i.film_id
FULL JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY r.rental_date;
--FULL JOIN (porque queremos ver todas las películas y todos los alquileres, incluso si alguna película nunca fue alquilada o algún alquiler ya no tiene su película en inventario) Ordenamos por fecha de alquiler.

--34 Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_gastado DESC
LIMIT 5;
-- INNER JOIN (customer – payment) Consulta agrupada (GROUP BY) para calcular el total gastado Ordenamos en descendente y limitamos a 5 registros.
--35 Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOHNNY';

--36 Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido
SELECT first_name AS "Nombre", last_name AS "Apellido"
FROM actor;


--37 Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN(actor_id) AS actor_id_minimo, MAX(actor_id) AS actor_id_maximo
FROM actor;

--38 Cuenta cuántos actores hay en la tabla “actorˮ.

SELECT COUNT(*) AS total_actores
FROM actor;

--39 Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name ASC;

--40 Selecciona las primeras 5 películas de la tabla “filmˮ

SELECT *
FROM film
LIMIT 5;
