--51 Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente
CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

--52 Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces
CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT 
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10;

--NNER JOIN (film → inventory → rental) Consulta agrupada Uso de HAVING para filtrar por cantidad de alquileres

--53  Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
SELECT DISTINCT f.title
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name = 'TAMMY'
  AND c.last_name = 'SANDERS'
  AND r.return_date IS NULL
ORDER BY f.title;
--INNER JOIN (customer → rental → inventory → film) Uso de condición r.return_date IS NULL para saber qué aún no fue devuelto

--54Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;

--55 Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM film f2
    JOIN inventory i2 ON f2.film_id = i2.film_id
    JOIN rental r2 ON i2.inventory_id = r2.inventory_id
    WHERE f2.title = 'SPARTACUS CHEAPER'
)
ORDER BY a.last_name;

-- Utilizo una subconsulta dentro del Where para analizar las peliculas antes de spartacus cheaper
-- Uso inner join para aunque abrevio en Join ya que me permite esta función y queda ligeramente más cómodo de leer el comando

--56 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ
SELECT DISTINCT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    inner JOIN film f ON fa.film_id = f.film_id
    inner JOIN film_category fc ON f.film_id = fc.film_id
    inner JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Music'
);

-- HAgo una subconsulta en film_actor además añado not in para que aparezcan aquellos que NO participaron y uso INNER JOIN dentro de la subconsulta

--57 Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
  AND DATE_PART('day', r.return_date - r.rental_date) > 8;


--58  Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ
SELECT DISTINCT f.title
FROM film f
inner JOIN film_category fc ON f.film_id = fc.film_id
WHERE fc.category_id = (
    SELECT category_id
    FROM category
    WHERE name = 'Animation'
);
--realizo una subconsulta sencilla en el Where y además previamente utilizo un inner join para unir las tablas de film y film_category

--59Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. Ordena los resultados alfabéticamente por título de película

SELECT title
FROM film
WHERE length = (
    SELECT length
    FROM film
    WHERE title = 'DANCING FEVER'
)
ORDER BY title;
-- se usa una subconsulta en where 

--60 Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT f.film_id) >= 7
ORDER BY c.last_name;


--61 Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;


--62  Encuentra el número de películas por categoría estrenadas en 2006
SELECT c.name AS categoria, COUNT(f.film_id) AS total_peliculas
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
WHERE f.release_year = 2006
GROUP BY c.name;


--63 Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT s.store_id, s.address_id, st.staff_id, st.first_name, st.last_name
FROM staff st
CROSS JOIN store s;

--AL querer utilizar todas las combinaciones posibles, necesitamos usar una cross join para obtener todas esas posibilidades

--64 Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

