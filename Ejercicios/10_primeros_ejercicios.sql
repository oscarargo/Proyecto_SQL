-- Crea el esquema de la BBDD

--2.Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

SELECT "title", RATING 
from "film"
WHERE RATING = 'R';

--3.Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

SELECT FIRST_NAME as "nombre" , LAST_NAME as "apellido"
from ACTOR AS A 
where ACTOR_ID BETWEEN 30 and 40;

--4 Obtén las películas cuyo idioma coincide con el idioma original.
SELECT "title" as "Título", ORIGINAL_LANGUAGE_ID as "ID Idioma original", LANGUAGE_ID as "ID idioma"
from FILM AS F 
where LANGUAGE_ID = ORIGINAL_LANGUAGE_ID;
-- NO HAY Películas que coincidan con el idioma original

--5 Ordena las películas por duración de forma ascendente.
SELECT TITLE as "Título", LENGTH as "Duración"
from FILM AS F 
order by LENGTH ASC ;
--6  Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select FIRST_NAME as "Nombre", LAST_NAME as "Apellido"
from ACTOR AS A 
WHERE LAST_NAME like '%ALLEN%';
-- Utilizamos los símbolos de porcentaje para que se especifique que queremos explícitamente ese apellido exacto.

--7 Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

SELECT rating, COUNT(*) AS total_peliculas
FROM film
GROUP BY rating
ORDER BY total_peliculas DESC;

--8 Encuentra el título de todas las películas que son ‘PG13ʼ o tienen una duración mayor a 3 horas en la tabla film.

SELECT title, rating, length
FROM film
WHERE rating = 'PG-13' OR length > 180;

--rating = 'PG-13': selecciona películas con clasificación PG-13.length > 180 ( asociado a los minutos, 180 min= 3horas): selecciona películas con duración mayor a 3 horas.Se usa OR para que se cumpla cualquiera de las dos condiciones.

--9 Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT VARIANCE(replacement_cost) AS varianza_reemplazo
FROM film;

SELECT STDDEV(replacement_cost) AS desviacion_estandar_reemplazo
FROM film;
-- Entendemos que medimos la variabilidad a traves de la varianza y la desviación estándar

--10 Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT 
    MIN(length) AS duracion_minima,
    MAX(length) AS duracion_maxima
FROM film;

SELECT title, length
FROM film
WHERE length = (SELECT MIN(length) FROM film);

-- Con la primera opción solo vemos que peliculas duran mas y menos en nuestra base de datos, sin embargo,
-- En la segunda formula podemos encontrar perfectamente las peliculas con menor duración y de mayor duración si modificamos el campo MAX, además usamos una subconsulta simple.
