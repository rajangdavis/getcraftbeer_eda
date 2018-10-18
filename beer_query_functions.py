
def beers_input_func(lli,dimi, beers):
    or_beer_query = " OR ".join([f"beers.name = '{beer}'" for beer in beers])
    return f"""
    SELECT 
    beers.id AS beer_id,
    beers.name as beer_name, 
    styles.name as style,
    AVG(reviews.review_overall) as overall,
    AVG(reviews.review_appearance) as appearance,
    AVG(reviews.review_aroma) as aroma,
    AVG(reviews.review_taste) as taste,
    AVG(reviews.review_palate) as palate,
    COUNT(reviews.id)
    FROM beers, reviews, styles 
    WHERE beers.style_id = styles.id 
    AND reviews.beer_id = beers.id 
    AND ({or_beer_query})
    GROUP BY beers.name, beers.id, styles.name;
    """    

def count_vect_for_beer(beer):
    inner_query = f"""
    SELECT 
    review_text_vector
    FROM beers, reviews
    WHERE
    review_text_vector IS NOT NULL
    AND reviews.beer_id = beers.id 
    AND beers.name = ''{beer}'';
    """.strip()

    full_text_search ="""
    SELECT word, ndoc, nentry
    FROM 
    ts_stat('""" + inner_query + """') ORDER BY ndoc DESC, nentry DESC"""
    return full_text_search


def local_beers_query_func(lli,dimi):
    return f"""
    SELECT ST_Distance(
        ST_GeomFromText('POINT({lli[0]} {lli[1]})', 4326), 
        ST_GeomFromText(ST_AsText(position), 4326)
    ) * 57.884 AS distance, 
    beers.name AS beer_name, 
    breweries.name AS brewery_name,
    AVG(reviews.review_overall) as overall,
    AVG(reviews.review_taste) as taste,
    AVG(reviews.review_aroma) as aroma,
    AVG(reviews.review_appearance) as appearance,
    AVG(reviews.review_palate) as palate,
    reviews.review_text_vector,
    styles.name as style
    FROM beers, breweries, styles, reviews
    WHERE beers.brewery_id = breweries.id
    AND beers.style_id = styles.id 
    AND beers.id = reviews.beer_id 
    AND char_length(reviews.review_text) >= 13 
    AND breweries.position IS NOT NULL
    AND ST_DWithin(
        ST_GeomFromText('POINT({lli[0]} {lli[1]})', 4326),
        ST_GeomFromText(ST_AsText(position),4326), 10/57.884
    )
    GROUP BY
    breweries.name,
    breweries.position,
    beers.name, 
    styles.name, review_text_vector
    ORDER BY distance ASC, overall DESC;
    """

