-- Programming Environment used is the pgAdmin 4 platform for PostgreSQL.
-- Business Question: Percentage of total revenue for each film category.

------------------------------------------------------------------------------------------------------------------------------------------
--B: CREATE detailed table

DROP TABLE IF EXISTS detailed;
CREATE TABLE detailed (
	category_id integer,
	name varchar(25),
	film_id integer,
	inventory_id integer,
	rental_id integer,
	amount numeric(5,2)
	);

-- To see empty detailed table
-- SELECT * FROM detailed;

-- CREATE summary table

DROP TABLE IF EXISTS summary;
CREATE TABLE summary (
	name varchar(25),
	amount numeric(7,2),
	percent_revenue varchar(10)
	);

-- To see empty summary table	
-- SELECT * FROM summary;

------------------------------------------------------------------------------------------------------------------------------------------
-- C: Extract raw data from dvdrentals to detailed table

DELETE FROM detailed;
INSERT INTO detailed (
	category_id,
	name,
	film_id,
	inventory_id,
	rental_id,
	amount
	)
SELECT 
	f.category_id,
	c.name,
	m.film_id,
	i.inventory_id,
	r.rental_id,
	p.amount
FROM category AS c
INNER JOIN film_category as f ON f.category_id = c.category_id
INNER JOIN film AS m ON m.film_id = f.film_id
INNER JOIN inventory AS i ON i.film_id = m.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p ON p.rental_id = r.rental_id;

-- To see contents of detailed table
-- SELECT * FROM detailed;

-- To verify accuracy, compare aggregated payment amount of summary table to raw data
-- SELECT SUM(amount) FROM payment;
-- SELECT SUM(amount) FROM summary;

------------------------------------------------------------------------------------------------------------------------------------------
-- D: CREATE FUNCTION to refresh summary table with data transformation
-- Transforming amount from detailed table with SUM aggregation to group by film categories
-- Transforming amount from detailed table to get a percentage
--	- The category amount SUM is multiplied by 100, then divided by the total amount SUM from the detailed table to get a percentage
--	- PostgreSQL does not support a percentage datatype
-- 	- 1 CAST converts the result of the previous division to a numeric with 2 decimal places
-- 	- 1 CAST converts the above result to a varchar with 5 places (to account for case when 1 category accounts for 100% of revenue)
--	- 1 CONCAT concatenates the above result with the '%' symbol as a string

CREATE FUNCTION summary_revenue()
RETURNS TRIGGER AS $$
BEGIN
DELETE FROM summary;
INSERT INTO summary (
	SELECT
		name,
	   	SUM(amount),
	   	CONCAT (
		CAST ( ( CAST (	( SUM(amount) * 100.0 / (SELECT SUM(amount) FROM detailed) ) AS numeric(3,2) ) ) AS varchar (10) ), 
		'%') AS percent_revenue
	FROM detailed
	GROUP BY name
	ORDER BY percent_revenue desc);
RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

SELECT * FROM summary;

-- E: CREATE TRIGGER

CREATE TRIGGER summary_refresh
AFTER INSERT ON detailed
FOR EACH STATEMENT
EXECUTE PROCEDURE summary_revenue();

-- F: CREATE STORED PROCEDURE

CREATE PROCEDURE refresh_revenue_reports()
LANGUAGE PLPGSQL
AS $$
BEGIN
DELETE FROM detailed;
INSERT INTO detailed (
	category_id,
	name,
	film_id,
	inventory_id,
	rental_id,
	amount
	)
SELECT 
	f.category_id,
	c.name,
	m.film_id,
	i.inventory_id,
	r.rental_id,
	p.amount
FROM category AS c
INNER JOIN film_category as f ON f.category_id = c.category_id
INNER JOIN film AS m ON m.film_id = f.film_id
INNER JOIN inventory AS i ON i.film_id = m.film_id
INNER JOIN rental AS r ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p ON p.rental_id = r.rental_id;
END;
$$;

-- To call stored procedure
-- CALL refresh_revenue_reports();

-- To see results
-- SELECT * FROM detailed;
-- SELECT * FROM summary;