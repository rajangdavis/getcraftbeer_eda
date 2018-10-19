# getcraftbeer - a recommender system for local craft beer

Craft beer sales for 2017 resulted in [$26 billion dollars in total sales in the United States alone](https://www.statista.com/topics/1806/craft-beer-in-the-us/).

Because of this growing trend, the number of breweries has steadily [increased 15.5% over the past 6 years](https://www.brewersassociation.org/statistics/number-of-breweries/).

As the number of breweries increases, the ability for consumers to make decisions about what beer they purchase becomes full of noise. There is some discussion that [the abundance of craft beer can fatigue beer enthusiasts](https://vinepair.com/articles/craft-beers-post-snob-era-is-here/).

To me, providing good, *actionable* recommendations for beer is crucial for alleviating this fatigue. 

[There is prior work with beer recommendation systems](http://www.recommend.beer/analysis/); however, providing a recommendation system that can recommend beers a user may like from breweries that are near adds tremendous value in that a user can act on the recommendation provided.

In this regard, I have scraped and attained scraped [Beer Advocate.com](beeradvocate.com) reviews, brewery and beer information, and GPS data to build such a system. The repo for the application, scraping, and database code for this application is located [here](https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/).

## 1. Technologies used:

1. Node JS:
    1. [axios](https://www.npmjs.com/package/axios) - This was used for making http requests for scraping Beer Advocate
    2. [cheerio](https://www.npmjs.com/package/axio) - This was used for scraping HTML from Beer Advocate
    3. [Sequelize](http://docs.sequelizejs.com/) - This is an Object Relational Modeler and Command Line Interface for using Node with Postgres
    4. [Express](https://expressjs.com/) - This is for making the my database remotely accessible
2. Python
    1. [pandas](https://pandas.pydata.org/) - This was used for data scrubbing and exploratory data analysis
    2. [sklearn](http://scikit-learn.org/stable/) - This was used for interpreting the strength of IPA's, the most dominant style in my dataset, in classifying reviews.
    3. [sqlalchemy](https://www.sqlalchemy.org/) - This was used for interacting with my Postgres Database within pandas
    4. [numpy](http://www.numpy.org/) - This was used for calculations within my Juptyer notebooks
    5. [matplotlib](https://matplotlib.org/) - This was used for data visualization within my notebooks
3. Bash - I used bash for building my database both in development and in production. A log of commands use can be found [here](https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/model_commands_and_relationships.txt)
4. [Postgres](https://www.postgresql.org/) - I used Postgres for my relational database as I have used it many times; however, this has been that largest implementation that I have worked with.
5. [PostGIS](https://postgis.net/) - I used PostGIS, a Postgres extension, for creatin
6. [Heroku](https://heroku.com) - I used Heroku for hosting and deploying my database and as well as for my application that powers the recommendation system that I am currently building.

## 2. Data Dictionary

The dataset was normalized into 4 tables on a Postgres server:

1. **Breweries** - 7,232 breweries from the United States

<table>
    <tr>
        <th>Features</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>id</td>
        <td>Id of Brewery within my database</td>
    </tr>
    <tr>
        <td>name</td>
        <td>Name of the brewery</td>
    </tr>
    <tr>
        <td>phone_number</td>
        <td>Phone Number of brewery as listed on Beer Advocate</td>
    </tr>
    <tr>
        <td>address</td>
        <td>Address of brewery as listed on Beer Advocate</td>
    </tr>
    <tr>
        <td>zipcode</td>
        <td>Zip code of brewery as listed on Beer Advocate</td>
    </tr>
    <tr>
        <td>city</td>
        <td>City of brewery as listed on Beer Advocate</td>
    </tr>
    <tr>
        <td>state</td>
        <td>State of brewery as listed on Beer Advocate</td>
    </tr>
    <tr>
        <td>country</td>
        <td>Country of brewery as listed on Beer Advocate (All breweries are located within the United States)</td>
    </tr>
    <tr>
        <td>website</td>
        <td>Website link of brewery as listed on Beer Advocate</td>
    </tr>
    <tr>
        <td>position</td>
        <td>Geolocation of brewery. This was generated using the OpenCage Geoencoder API and the address of the brewery</td>
    </tr>
    <tr>
        <td>features</td>
        <td>This is a list of attributes that a brewery may have. </td>
    </tr>
    <tr>
        <td>ba_link</td>
        <td>This is the URL for the brewery on Beer Advocate</td>
    </tr>
</table>

2. **Beer Styles** - 112 styles of beer
<table>
    <tr>
        <th>Features</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>id</td>
        <td>The id of the beer style in my database</td>
    </tr>
    <tr>
        <td>name</td>
        <td>The name of the beer style in my database</td>
    </tr>
    <tr>
        <td>ba_link</td>
        <td>This is the style for the brewery on Beer Advocate</td>
    </tr>
    <tr>
        <td>abv_range</td>
        <td>This is the range of ABV for the style of beer</td>
    </tr>
    <tr>
        <td>ibu_range</td>
        <td>This is the range of bitterness measured in <a href="https://en.wikipedia.org/wiki/Beer_measurement#Bitterness">International Bitterness Units</a> for the style of beer</td>
    </tr>
    <tr>
        <td>glassware</td>
        <td>This is the recommended glassware for the style of beer</td>
    </tr>
    <tr>
        <td>description</td>
        <td>This is the description of the beer on Beer Advocate</td>
    </tr>
</table>

3. **Beers** - 197,474 beers 
<table>
    <tr>
        <th>Features</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>id</td>
        <td>This is the id of the beer in my database</td>
    </tr>
    <tr>
        <td>name</td>
        <td>This is the name of the beer</td>
    </tr>
    <tr>
        <td>brewery_id</td>
        <td>This is the id of brewery within my database that makes the beer</td>
    </tr>
    <tr>
        <td>style_id</td>
        <td>This is the id of style within my database that the beer is categorized under</td>
    </tr>
    <tr>
        <td>ba_link</td>
        <td>This is the URL for the beer on Beer Advocate</td>
    </tr>
    <tr>
        <td>ba_availability</td>
        <td>This is availability of the beer as supplied on Beer Advocate</td>
    </tr>
    <tr>
        <td>ba_description</td>
        <td>This is description of the beer as supplied on Beer Advocate</td>
    </tr>
    <tr>
        <td>abv</td>
        <td>This is the ABV the beer as supplied on Beer Advocate</td>
    </tr>
    <tr>
        <td>rating_counts</td>
        <td>This is the number of reviews as supplied on Beer Advocate</td>
    </tr>
    <tr>
        <td>total_score</td>
        <td>This is the overall score of the beer as supplied on Beer Advocate</td>
    </tr>
</table>

4. **Reviews** -  2,202,977 beers reviews - 656,143 with text
<table>
    <tr>
        <th>Features</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>id</td>
        <td>This is the id of my review as supplied on Beer Advocate</td>
    </tr>
    <tr>
        <td>beer_id</td>
        <td>This is the id of the beer that the review is written for on Beer Advocate</td>
    </tr>
    <tr>
        <td>review_overall</td>
        <td>This is the overall score for a beer on a review</td>
    </tr>
    <tr>
        <td>review_taste</td>
        <td>This is the taste score for a beer on a review</td>
    </tr>
    <tr>
        <td>review_aroma</td>
        <td>This is the smell score for a beer on a review</td>
    </tr>
    <tr>
        <td>review_palate</td>
        <td>This is the mouth feel score for a beer on a review</td>
    </tr>
    <tr>
        <td>review_appearance</td>
        <td>This is the appearance score for a beer on a review</td>
    </tr>
    <tr>
        <td>review_text</td>
        <td>This is the review text for a beer on a review</td>
    </tr>
    <tr>
        <td>review_profilename</td>
        <td>This is the profile name of the user that wrote the review</td>
    </tr>
    <tr>
        <td>review_time</td>
        <td>This is the time the review was created</td>
    </tr>    
</table>

## 2. Obtaining data

I obtained publicly available datasets from [ data.world ](https://data.world) and scraped Beer Advocate for beer, brewery, beer style, and review information. I acquired geographic information using the addresses provided by Beer Advocate and utilizing the [ OpenCage Geocoder API ](https://opencagedata.com/api) for deriving coordinates for each brewery.

I could have scraped the entirety of my dataset from Beer Advocate; however, I wanted to avoid this because I don't like the idea of 
<br>
<br>Here is a break down of the datasets and the scripts I used for scraping beer advocate data:
<ol>
    <li>Datasets from <a href="https://data.world">data.world</a>:
        <ol>
            <li><a href="https://data.world/socialmediadata/beeradvocate">1.5 million reviews from Beer Advocate with scores only</a>
                <table>
                    <tr>
                        <th>Features</th>
                        <th>Definition</th>
                    </tr>
                    <tr>
                        <td>brewery_id</td>
                        <td>ID of brewery wher beer was made</td>
                    </tr>
                    <tr>
                        <td>brewery_name</td>
                        <td>Name of brewery where beer was made</td>
                    </tr>
                    <tr>
                        <td>review_time</td>
                        <td>Creation date of review in Unix time</td>
                    </tr>
                    <tr>
                        <td>review_overall</td>
                        <td>Overall score</td>
                    </tr>
                    <tr>
                        <td>review_aroma</td>
                        <td>Score for smell of beers</td>
                    </tr>
                    <tr>
                        <td>review_appearance</td>
                        <td>Score for appearance of beer</td>
                    </tr>
                    <tr>
                        <td>review_profilename</td>
                        <td>Profilename of the user that made the review</td>
                    </tr>
                    <tr>
                        <td>beer_style</td>
                        <td>Style of beer in string format</td>
                    </tr>
                    <tr>
                        <td>review_palate</td>
                        <td>Score for mouth feel</td>
                    </tr>
                    <tr>
                        <td>review_taste</td>
                        <td>Score for taste of beer</td>
                    </tr>
                    <tr>
                        <td>beer_name</td>
                        <td>Name of beer being reviewed</td>
                    </tr>
                    <tr>
                        <td>beer_abv</td>
                        <td>Alcohol percentage of beer</td>
                    </tr>
                    <tr>
                        <td>beer_beerid</td>
                        <td>ID of beer being reviewed</td>
                    </tr>
                </table>
            </li>
            <li>
                <a href="https://data.world/petergensler/beer-advocate-reviews">528,870 Reviews from Beer Advocate some of which had text reviews</a>
                <table>
                    <tr>
                        <th>Features</th>
                        <th>Definition</th>
                    </tr>
                    <tr>
                        <td>beer_abv</td>
                        <td>Alcohol percentage of beer</td>
                    </tr>
                    <tr>
                        <td>beer_beerid</td>
                        <td>ID of beer being reviewed</td>
                    </tr>
                    <tr>
                        <td>beer_brewerid</td>
                        <td>ID of brewery wher beer was made</td>
                    </tr>
                    <tr>
                        <td>beer_name</td>
                        <td>Name of beer being reviewed</td>
                    </tr>
                    <tr>
                        <td>beer_style</td>
                        <td>Style of beer in string format</td>
                    </tr>
                    <tr>
                        <td>review_appearance</td>
                        <td>Score for appearance of beer</td>
                    </tr>
                    <tr>
                        <td>review_aroma</td>
                        <td>Score for smell of beer</td>
                    </tr>
                    <tr>
                        <td>review_overall</td>
                        <td>Score for appearance of beer</td>
                    </tr>
                    <tr>
                        <td>review_palate</td>
                        <td>Score for mouth feel of beer</td>
                    </tr>
                    <tr>
                        <td>review_profilename</td>
                        <td>Profile name of the user making review</td>
                    </tr>
                    <tr>
                        <td>review_taste</td>
                        <td>Score for taste of beer</td>
                    </tr>
                    <tr>
                        <td>review_text</td>
                        <td>Corpus for review</td>
                    </tr>
                    <tr>
                        <td>review_time</td>
                        <td>Creation date of the review in Unix Time</td>
                    </tr>        
                </table>
            </li>
        </ol>
    </li>
    <li>
        I scraped <a href="beeradvocate.com">Beer Advocate</a> using the <a href="https://www.npmjs.com/package/axios">axios</a> and <a href="https://cheerio.js.org/">cheerio</a> libraries from the NodeJS ecosystem. <a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts">Scripts are located here</a>.<br><br>Here is a brief explanation of what each script does:
        <table>
            <tr>
                <th>Script Name</th>
                <th>What does it do</th>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/scrape_ba.js">scrape_ba.js</a></td>
                <td>This was the initial script I created to scrape Beer Advocate.com. I grabbed all of the <a href="https://www.beeradvocate.com/place/directory/0/US/">places by state hyperlinks</a>). From some investigation, I knew that appending '?c_id=US&s_id=[STATE]&brewery=Y' to the URL would filter the places by breweries by state.
                <br><br>Once the brewery list for a state is retrieved, I have the script look at the number of results and calculate the number of subsequent pages to scrape. The script then grabs all of the brewery location information for each brewery and number of beers by state.
                </td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/scrape_brewery_page.js">scrape_brewery_page.js</a></td>
                <td>After getting the brewery information, this helped me calculate roughly how many beers I will need to scrape.<br><br>
                Each brewery page will have a list of all of it's beers by name, style, percentage of alcohol (ABV), number of ratings, and overall score.
                <br><br>After I scraped each page, I created a unique JSON file for each brewery. This was to get around git hub file upload limits.</td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/extract_style.js">extract_style.js</a></td>
                <td>This script looked though all of the brewery JSON files and extracted the styles for each beer. I then streamed the unique styles to the terminal and piped the output to a JSON file</td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/scrape_styles.js">scrape_styles.js</a></td>
                <td>From the styles JSON file, I was able to generate a list of links to scrape the descriptions for all of the styles within my dataset. I scraped the style descriptions for each style present in my dataset.</td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/extract_flat_beer.js">extract_flat_beer.js</a></td>
                <td>This script goes through all of the brewery JSON files and create a flat JSON file of all of the beer JSON objects. This for me to be able to push the data into a database.</td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/extract_rating_counts.js">extract_rating_counts.js</a></td>
                <td>This script reads through my brewery JSON files and generates summary statistics regarding the total number of reviews that I could possibly scrape.</td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/scrape_breweries_lat_long.js">scrape_breweries_lat_long.js</a></td>
                <td>This script utilized the <a href="https://opencagedata.com/api">OpenCage Geocoder API</a> to </td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/scrape_beers.js">scrape_beers.js</a></td>
                <td>This script would query my database and utilize the scrape_beer_html.js module to scrape beer reviews as well as beer descriptions and availability from Beer Advocate. Once the desired information was scraped, it would be saved to a Postgres database.<br><br> I set up this script to prioritize scraping beers closest to Southern California that did not have reviews on my database. This was to help with at least</td>
            </tr>
            <tr>
                <td><a href="https://bitbucket.org/rajangdavis/getcraftbeer/src/heroku/scrape_extract_scripts/scrape_beer_html.js">scrape_beer_html.js</a></td>
                <td>This script contains a module I wrote for scraping beer review scores with and without review text from Beer Advocate.<br><br>The structure of the HTML for these reviews was incredibly difficult to scrape given that some reviews only had an overall score, a set of scores, or scores with a text review. Additionally, when review text was present, it was structured between elements which makes it difficult to scrape without getting text from other elements within the HTML.<br><br>While using <a href="https://en.wikipedia.org/wiki/XPath">XPath selectors</a> is a standard work around, the variable nature of the HTML structure made it problematic to utilize.<br><br>My work around was to grab the text in a way that I could preserve the original structure of the HTML and convert the text nodes into a list/array. Because the overall score would always be at the top and the username and the date the review was posted would always be at the bottom of the HTML structure, I would search and filter the text nodes in between in order to determine what they were. I then mapped these values to a JSON object and return a list of these JSON objects for processing.</td>
            </tr>
        </table>
    </li>
</ol>

### 3. Scrubbing data

Scrubbing data is still *technically* in process. Areas that need to be improved are as follows:

1. All of the text data should be cleaned up to use UTF8. This is incredibly evident with the beer style descriptions as they will sometimes appear corrupted when working in pandas. This is less evident when working with data on Postgres directly.
2. There are is some level of duplicated data within the reviews. I have done my best to address this as much as possible (); however, I have identified at least 125 beers with slightly more reviews in the database than they should.
3. Scrubbing and merging of Datasets from [data.world](https://data.world) are covered in [this notebook](notebooks/Joining%20Datasets.ipynb)
4. There is a lot of missing values for the review text; however, that is the nature of how Beer Advocate allows for beers.

As far as typing/data consistency is concerned, I am not too worried given that I have the data stored on a database.

### 4. Exploring data

Most of my EDA was performed using [Postgres directly](sql_queries.sql); however, I started looking at how to plot the beer varieties within a given area[Postgres directly](notebooks/Data%20Visualization.ipynb).

### 5. Recommendation System Architecture

This is still in progress; however, there are a few key ideas that I want to take advantage of in building out my recommendation system:

1. [Client-Server Architecture](https://en.wikipedia.org/wiki/Client%E2%80%93server_model) - This allows me to orchestrate the mechanisms of the recommendations such that calculations for Cosine Simularity and Term Frequency Inverse Document Frequency can be pushed to the user. This simplifies most of the work of the server in that all it needs to do is be a query interface.

2. [Geolocation API](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API) - This API allows browsers to get accurate GPS positioning for mobile and desktop clients. The other advantage of using GPS is that it limits the scope of calculation.

3. [Postgres Fulltext Search](https://www.postgresql.org/docs/9.5/static/textsearch.html) - This is a feature of Postgres that I was not aware of when planning for this project; however, this feature provides several advantages that add a lot of value to my recommendation system.

Fulltext Search works by taking a document, lower casing all of the featuress, removes [stop words](https://en.wikipedia.org/wiki/Stop_words), [stem words](https://en.wikipedia.org/wiki/Stemming) to their base [lexeme](https://en.wikipedia.org/wiki/Lexeme), and providing the position of terms within the given document.

The result is a custom datatype called a ['ts_vector'](https://www.postgresql.org/docs/10/static/datatype-textsearch.html):

```sql
SELECT 'a:1 fat:2 cat:3 sat:4 on:5 a:6 mat:7 and:8 ate:9 a:10 fat:11 rat:12'::tsvector;
                              tsvector
-------------------------------------------------------------------------------
 'a':1,6,10 'and':8 'ate':9 'cat':3 'fat':2,11 'mat':7 'on':5 'rat':12 'sat':4

```

The benefit of fulltext search for architecting a recommendation system is two-fold:
1. The ability to search text within locally reviewed breweries to limit the search space of a user to terms that the user wishes to match against.

2. Provides the basis for calculating Cosine Simularity and Term Frequency Inverse Document Frequency. Here are python and node examples of how Cosine Simularity can be calculated using ts_vectors:
```python
# https://stackoverflow.com/questions/41827983/right-way-to-calculate-the-cosine-similarity-of-two-word-frequency-dictionaries
import math
# borrowed from
# https://stackoverflow.com/questions/41827983/right-way-to-calculate-the-cosine-similarity-of-two-word-frequency-dictionaries
def cosine_dic(dic1,dic2):
    numerator = 0
    dena = 0
    for key1,val1 in dic1.items():
        numerator += val1*dic2.get(key1,0)
        dena += val1*val1
    denb = 0
    for val2 in dic2.values():
        denb += val2*val2
    return numerator/math.sqrt(dena*denb)

# These are strigified ts_vectors from postgres
review_text_vectors = [
"'22':105 'aftertast':93 'american':41 'auster':90 'beer':98 'bitter':92 'bottl':107 'breweri':111 'brown':5,42 'burnt':27 'chaser':99 'clear':1 'club':81 'coffe':24 'dark':2 'driest':40 'duvel':12 'els':102 'ever':45 'faint':17 'faintest':31 'flavor':28,80 'foam':9 'get':48 'leav':94 'lot':25 'malti':32 'mean':69 'modest':8 'must':35 'nice':73 'note':33 'nutti':58 'one':37 'overal':83 'oz':106 'plain':86 'purchas':108 'rather':49 'red':4 'red-brown':3 'sharp':50 'sip':53 'slight':57 'soda':82 'someth':101 'spritzi':61 'straightforward':88 'taproom':112 'tast':46,59 'tongu':64 'tulip':13 'vanilla':20 've':44 'want':96 'way':74 'whiff':18 'yesterday':22",
"'bbq':25 'beach':28 'bitter':8 'bt':23 'chocol':14 'coffe':4,20 'dark':13 'enjoy':21 'hop':10 'huntington':27 'lot':2,16 'malt':18 'one':7 'recommend':29 'wow':1",

"'a-clear':1 'amber':4 'balanc':31 'bitter':38 'bodi':42 'breweri':55 'carbon':6,44 'citrus':13,27 'clear':3 'dirt':14,28 'drink':46 'earthi':12,26 'easi':45 'end':35 'finger':8 'good':37 'great':50 'head':9 'hop':17 'ipa':51 'littl':58 'local':54 'lot':15 'm':40 'm-medium':39 'medium':41 'nose':24 'note':29 'o':48 'o-a':47 'one':7 'pleasant':69 's-earthi':10 'similar':21 't-veri':18 'togeth':32 'tri':62 'turn':66 'worri':59",
"'ale':49 'almost':6 'amber':4 'bad':24 'basic':46 'bubbl':12 'carbon':9 'citrus':19,30 'complex':37 'consequ':14 'drink':65 'easi':63 'floral':21 'get':29 'go':57 'hop':22 'ipa':53 'isn':34 'lace':16 'line':43 'lot':56 'much':36 'nose':17 'opaqu':3 'orang':31 'pale':48 'pour':1 'rather':50 'simpl':27 'specif':32 'starter':47 'tast':25 'virtual':10 'visibl':8"
]

# this woa made to parse teh dicioinaries
def clean_vectors(review_text_vectors):
    count_dicts = []
    for rtv in review_text_vectors:
        split_terms = [ r.replace("'","").split(":")  for r  in rtv.split(" ")]
        count_dicts.append({term[0]: len(term[1].split(",")) for term in split_terms}) 
    return count_dicts

count_dicts = clean_vectors(review_text_vectors )

matrix = []
for cd in count_dicts:
    row = []
    for cdl in count_dicts:
        row.append(cosine_dic(cd, cdl))
    matrix.append(row)

print(matrix)

# [
#   [1.0, 0.18661690879115475, 0.10264286388534141, 0.10042266465917388],
#   [0.18661690879115475, 1.0, 0.1527830828380352, 0.10762440050012628],
#   [0.10264286388534141, 0.1527830828380352, 1.0, 0.29926601608548503],
#   [0.10042266465917388, 0.10762440050012628, 0.29926601608548503, 1.0]
# ]
```

By transforming ts_vectors into strings and then dictionaries, calculating text simularities between reviews can be efficiently calculated without storing redudant information.

I am planning on revealing a prototype on 10/22 that will layer full-text search,  cosine simularities of scores, cosine simularities of count vectors, cosine simularities with term frequency inverse document frequency factored in. The link to the prototype can be found [here](https://shielded-brushlands-72807.herokuapp.com/).


### 6. Further Exploration
    - Looking at network model
    - More EDA
    - Collaborative filtering
    - Build a REST API
    - Build a GraphQL endpoint