import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os
import re
from sqlalchemy import create_engine, text as sql
from sklearn.metrics.pairwise import cosine_similarity
from beer_query_functions import local_beers_query_func, beers_input_func, count_vect_for_beer

pg_pass = os.environ['BEER_DB']
engine = create_engine(pg_pass)

def make_local_recommendations(**kwargs):
    lli = kwargs.get("lat_long_input")
    dimi = kwargs.get("distance_in_miles_input")
    ucbi = kwargs.get("user_chosen_beers_input")
    local_beers_query_string = local_beers_query_func(lli, dimi)
    beers_input_string, or_beer_query  = beers_input_func(lli, dimi, ucbi)
    local_beers_results = pd.read_sql(local_beers_query_string, con=engine, params={"or_beer_query":or_beer_query})
    beers_input_results = pd.read_sql(beers_input_string, con=engine)
    local_beers_styles = local_beers_results[local_beers_results["style"].isin(set(beers_input_results["style"]))]['style'].unique()
    local_beers_matches = local_beers_results[local_beers_results["style"].isin(local_beers_styles)].dropna()
    beer_list = [f"{beer}" for beer in local_beers_matches["beer_name"].tolist() + ucbi]
    full_text_search = count_vect_for_beer(beer_list[0])
    beer_sim_mat = pd.concat([
        beers_input_results.groupby(["beer_name"])[["overall", "appearance","aroma","taste","palate"]].mean(),
        local_beers_matches.groupby(["beer_name"])[["overall", "appearance","aroma","taste","palate"]].mean()
    ])
    rtv = local_beers_matches.groupby(["beer_name"]).review_text_vector.agg(lambda col: ' '.join(col))
    beer_sim_mat_cubed = np.power(beer_sim_mat, 3)
    sim_matrix = cosine_similarity(beer_sim_mat_cubed, beer_sim_mat_cubed)
    return (pd.DataFrame(sim_matrix, index=beer_sim_mat.index, columns=beer_sim_mat.index))
    
eric_yoo = make_local_recommendations(
    lat_long_input = (33.982707, -118.38276), 
    distance_in_miles_input = 10, 
    user_chosen_beers_input = [
        'Dog Ate My Homework', 
        'Foggy Window', 
        'Pabst Blue Ribbon (PBR)'])

print(eric_yoo)