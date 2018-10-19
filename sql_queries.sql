-- Grab LA Breweries
SELECT 
name, zipcode 
FROM breweries 
WHERE CAST(
    split_part(zipcode,'-', 1) AS INTEGER
) IN (
    90001,90021,90044,90077,90502,
    91330,91504,90002,90023,90045,
    90089,90710,91331,91505,90003,
    90024,90046,90094,90717,91335,
    91601,90004,90025,90047,90095,
    90731,91340,91602,90005,90026,
    90048,90210,90732,91342,91604,
    90005,90027,90049,90211,90732,
    91343,91605,90006,90028,90056,
    90212,90744,91344,91606,90007,
    90029,90057,90230,90810,91345,
    91607,90008,90031,90058,90232,
    91040,91352,91608,90010,90032,
    90059,90245,91042,91356,90011,
    90033,90061,90247,91214,91364,
    90012,90034,90062,90248,91303,
    91367,90013,90035,90063,90272,
    91304,91401,90014,90036,90064,
    90290,91306,91402,90015,90037,
    90065,90291,91307,91403,90016,
    90038,90066,90292,91311,91405,
    90017,90039,90067,90293,91316,
    91406,90018,90041,90068,90302,
    91324,91411,90019,90042,90069,
    90402,91325,91423,90020,90043,
    90071,90501,91326,91436
);

-- Grab beers, brewery name and style from "The Bruery"
SELECT 
beers.name AS beer_name, 
breweries.name AS brewery_name, 
styles.name 
FROM beers,breweries,styles 
WHERE beers.brewery_id = breweries.id 
AND beers.style_id = styles.id 
AND breweries.name 
LIKE '%Bruery%';

-- Grab beers, brewery name and style from Breweries in LA
SELECT 
beers.name AS beer_name, 
breweries.name AS brewery_name, 
styles.name FROM beers,breweries, 
styles 
WHERE 
beers.brewery_id = breweries.id 
AND beers.style_id = styles.id 
AND CAST(split_part(breweries.zipcode,'-', 1) AS INTEGER) 
in (
    90001,90021,90044,90077,90502,
    91330,91504,90002,90023,90045,
    90089,90710,91331,91505,90003,
    90024,90046,90094,90717,91335,
    91601,90004,90025,90047,90095,
    90731,91340,91602,90005,90026,
    90048,90210,90732,91342,91604,
    90005,90027,90049,90211,90732,
    91343,91605,90006,90028,90056,
    90212,90744,91344,91606,90007,
    90029,90057,90230,90810,91345,
    91607,90008,90031,90058,90232,
    91040,91352,91608,90010,90032,
    90059,90245,91042,91356,90011,
    90033,90061,90247,91214,91364,
    90012,90034,90062,90248,91303,
    91367,90013,90035,90063,90272,
    91304,91401,90014,90036,90064,
    90290,91306,91402,90015,90037,
    90065,90291,91307,91403,90016,
    90038,90066,90292,91311,91405,
    90017,90039,90067,90293,91316,
    91406,90018,90041,90068,90302,
    91324,91411,90019,90042,90069,
    90402,91325,91423,90020,90043,
    90071,90501,91326,91436
);

-- Grab beers from breweries in California, Illinios, and Minnesota
SELECT 
beers.name AS beer_name, 
beers.ba_link AS beer_link, 
beers.rating_counts FROM beers,breweries 
WHERE beers.brewery_id = breweries.id  
AND breweries.state 
IN ('California', 'Illinios', 'Minnesota');


-- Grab 10 closest breweries to Chicago
SELECT 
ST_Distance(
    ST_GeomFromText('POINT(42.2008575 -88.2145259)', 4326),
    ST_GeomFromText(ST_AsText(position), 4326)
) AS distance, 
ST_AsText(position) AS position, 
name, city, state, ba_link 
FROM breweries WHERE position IS NOT NULL 
ORDER BY distance LIMIT 10;



-- Grab 10 closest breweries to GA
SELECT 
ST_Distance(
    ST_GeomFromText('POINT(34.01080683333333 -118.4922238333333)', 4326),
    ST_GeomFromText(ST_AsText(position), 4326)
) AS distance, 
ST_AsText(position) AS position, 
name, city, state, ba_link 
FROM breweries WHERE position IS NOT NULL 
ORDER BY distance LIMIT 10;


-- Grab review text
-- for beers near Cerritos CA
SELECT 
reviews.review_text
FROM beers,breweries, styles, reviews
WHERE beers.brewery_id = breweries.id 
AND beers.style_id = styles.id
AND breweries.position IS NOT NULL 
AND ST_DWithin(
    ST_GeomFromText('POINT(33.8548734 -118.06258630000002)', 4326),
    ST_GeomFromText(ST_AsText(position), 4326), 
    10/57.884
)
AND reviews.beer_id = beers.id
AND char_length(reviews.review_text) BETWEEN 13 AND 700;


-- Grab the beers with styles from breweries 10 miles (rounded) AS the crow flies
-- Near Santa Monica
SELECT ST_Distance(
    ST_GeomFromText('POINT(34.01080683333333 -118.4922238333333)', 4326), 
    ST_GeomFromText(ST_AsText(position), 4326)
) * 57.884 AS distance, 
beers.name AS beer_name, 
breweries.name AS brewery_name,
styles.name as style
FROM beers, breweries, styles, reviews
WHERE beers.brewery_id = breweries.id
AND beers.style_id = styles.id 
AND beers.id = reviews.beer_id 
AND breweries.position IS NOT NULL
AND ST_DWithin(
    ST_GeomFromText('POINT(34.01080683333333 -118.4922238333333)', 4326),
    ST_GeomFromText(ST_AsText(position),4326), 10/57.884
)
ORDER BY distance ASC, total_score DESC;



-- Get the count of reviews at each beer and brewery
-- within 10 miles
SELECT 
reviews.beer_id,
beer.name,
styles.name,
COUNT(reviews.review_text)
FROM reviews, beers, breweries, styles
WHERE reviews.beer_id = beers.id
AND beers.brewery_id = breweries.id
AND styles.id = beers.style_id
AND ST_DWithin(
    ST_GeomFromText('POINT(34.01080683333333 -118.4922238333333)', 4326),
    ST_GeomFromText(ST_AsText(breweries.position),4326), 10/57.884
)

GROUP BY breweries.name, styles.name, reviews.beer_id;

-- Sum of counts by state
-- Using this to calculate which lat longs I should grab today 10/12
WITH state_counts AS (
    SELECT 
    COUNT(name) as count 
    FROM breweries 
    WHERE position IS NULL 
    GROUP BY state 
    ORDER BY COUNT ASC
)

SELECT SUM(count) FROM state_counts;


-- Gets the beers with "best beer ever"
-- In their reviews
SELECT beers.name, COUNT(reviews.id)
FROM beers, reviews 
WHERE beers.name = reviews.beer_id
AND id.review_text_vector @@ plainto_tsquery('best beer ever') IS TRUE
GROUP BY beers.name
ORDER BY COUNT(reviews.id) DESC;


-- Finding beers without reviews
SELECT COUNT(id)
FROM beers b
WHERE b.id NOT IN (
    SELECT DISTINCT beer_id
    FROM reviews
    WHERE beer_id IS NOT NULL
);

SELECT 
ST_Distance(
    ST_GeomFromText('POINT(34.01080683333333 -118.4922238333333)', 4326),
    ST_GeomFromText(ST_AsText(bw.position), 4326)
) AS distance, 
bw.name, bw.city, bw.state,
b.ba_link, b.name, b.rating_counts
FROM breweries bw, beers b
WHERE b.brewery_id = bw.id
AND b.ba_availability = ''
AND position IS NOT NULL 
AND b.rating_counts > 0
AND b.id NOT IN (
    SELECT DISTINCT beer_id
    FROM reviews
    WHERE beer_id IS NOT NULL
)
GROUP BY distance,
bw.name, bw.city, bw.state,
b.ba_link, b.name, b.rating_counts
ORDER BY distance;


SELECT 
ST_Distance(  
    ST_GeomFromText('POINT(34.01080683333333 -118.4922238333333)', 4326),
    ST_GeomFromText(ST_AsText(bw.position), 4326)
) AS distance, 
LEFT(bw.name, 25) as bw_name, 
LEFT(bw.city, 10), bw.state, 
b.id, LEFT(b.name, 25) as beer_name, 
b.rating_counts 
FROM breweries bw, 
beers b WHERE b.brewery_id = bw.id 
AND b.rating_counts > 0 
AND b.ba_availability IS NULL 
AND b.id NOT IN (      
    SELECT DISTINCT beer_id         
    FROM reviews    
    WHERE beer_id IS NOT NULL 
) ORDER BY distance, rating_counts DESC;


-- Delete Duplications
-- Did not perform on production
DELETE 
FROM reviews
WHERE id IN (
    SELECT id
    FROM (
        SELECT id,
           ROW_NUMBER() 
           OVER (
               partition 
               BY beer_id,
               review_profilename, 
               review_overall,
               review_taste,
            review_appearance,
            review_palate,
            review_time,
            review_text,
            review_aroma 
            ORDER BY id
        ) AS rnum
    FROM reviews) r
    WHERE r.rnum > 1);
