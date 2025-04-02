--11Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT p.amount, r.rental_date
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
ORDER BY r.rental_date
OFFSET 2 LIMIT 1;
-- Con estos datos lo que hacemos es obtener el valor de los alquileres, al ussar offset limitamos los dos primeros que no queremos y limit 1 para coger el antepenúltimo

 -- 12Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC17ʼ ni ‘Gʼ en cuanto a su clasificación.
SELECT title, rating
FROM film
WHERE rating NOT IN ('NC-17', 'G');


--13 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración

SELECT rating, AVG(length) AS promedio_duracion
FROM film
GROUP BY rating
ORDER BY promedio_duracion DESC;

--14 Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT title, length
FROM film
WHERE length > 180;

--15 ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM(amount) AS total_ingresos
FROM payment;

--16 Muestra los 10 clientes con mayor valor de id.

SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;

--17 Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

SELECT a.first_name, a.last_name
FROM actor a
inner JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'EGG IGBY';

--18 Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT title
FROM film;

--19 Encuentra el título de las películas que son comedias y tienen una  duración mayor a 180 minutos en la tabla “filmˮ.
SELECT f.title, f.length, c.name AS categoria
FROM film f
inner JOIN film_category fc ON f.film_id = fc.film_id
inner JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy' AND f.length > 180;
-- En este caso utilizamos la técnica de Inner debido a que queremos rescatar los datos de la tabla comedy


--20   Encuentra las categorías de películas que tienen un promedio de  duración superior a 110 minutos y muestra el nombre de la categoría 
SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion
FROM film f
inner JOIN film_category fc ON f.film_id = fc.film_id
inner JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
HAVING AVG(f.length) > 110;

-- En este caso nos interesan las películas que tienen categoría y categorías que tengan películas asociadas.

