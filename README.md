# getcraftbeer - a recommender system for local craft beer

Craft beer sales for 2017 resulted in [$26 billion dollars in total sales in the United States alone](https://www.statista.com/topics/1806/craft-beer-in-the-us/).

Because of this growing trend, the number of breweries has steadily [increased 15.5% over the past 6 years](https://www.brewersassociation.org/statistics/number-of-breweries/).

As the number of breweries increases, the ability for consumers to make decisions about what beer they purchase becomes full of noise. There is some discussion that [the abundance of craft beer can fatigue beer enthusiasts](https://vinepair.com/articles/craft-beers-post-snob-era-is-here/).

To me, providing good, *actionable* recommendations for beer is crucial for alleviating this fatigue. 

[There is prior work with beer recommendation systems](http://www.recommend.beer/analysis/); however, providing a recommendation system that can recommend beers a user may like from breweries that are near adds tremendous value in that a user can act on the recommendation provided.

In this regard, I have scraped and attained scraped [Beer Advocate.com](beeradvocate.com) reviews, brewery and beer information, and GPS data to build such a system. The repo for the application, scraping, and database code for this application is located [here](https://github.com/rajangdavis/ba_scrape).

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
3. Bash - I used bash for building my database both in development and in production. A log of commands use can be found [here](https://github.com/rajangdavis/ba_scrape/blob/master/model_commands_and_relationships.txt)
4. [Postgres](https://www.postgresql.org/) - I used Postgres for my relational database as I have used it many times; however, this has been that largest implementation that I have worked with.
5. [PostGIS](https://postgis.net/) - I used PostGIS, a Postgres extension, for creatin
6. [Heroku](https://heroku.com) - I used Heroku for hosting my database and I will use this for my application
7. [jq](https://stedolan.github.io/jq/) - I used jq for cleaning up some of the JSON data and for some data wrangling 

## 2. Data Dictionary

The dataset was normalized into 4 tables:

1. Breweries -  
2.
3.
4.

### Brewery features:
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



### Beer Style features:
<table>
    <tr>
        <th>Features</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>id</td>
        <td></td>
    </tr>
    <tr>
        <td>name</td>
        <td></td>
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
        <td>This is the range of bitterness measured in (Internation Bitterness Units)[https://en.wikipedia.org/wiki/Beer_measurement#Bitterness] for the style of beer</td>
    </tr>
    <tr>
        <td>glassware</td>
        <td>This is the recommended glassware for the style of beer</td>
    </tr>
    <tr>
        <td>description</td>
        <td>This is the description of the beer</td>
    </tr>
</table>

### Beer features:
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


### Review features:
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
                        <td>Score for mouthfeel</td>
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
        I scraped <a href="beeradvocate.com">Beer Advocate</a> using the <a href="https://www.npmjs.com/package/axios">axios</a> and <a href="https://cheerio.js.org/">cheerio</a> libraries from the NodeJS ecosystem. <a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts">Scripts are located here</a>. Here is a brief explanation of what each script does:
        <table>
            <tr>
                <th>Script Name</th>
                <th>What does it do</th>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_ba.js">scrape_ba.js</a></td>
                <td>This was the initial script I created to scrape Beer Advocate.com. I grabbed all of the <a href="https://www.beeradvocate.com/place/directory/0/US/">places by state hyperlinks</a>). From some investigation, I knew that appending '?c_id=US&s_id=[STATE]&brewery=Y' to the URL would filter the places by breweries by state.
                <br><br>Once the brewery list for a state is retrieved, I have the script look at the number of results and calculate the number of subsequent pages to scrape. The script then grabs all of the brewery location information for each brewery and number of beers by state.
                </td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_brewery_page.js">scrape_brewery_page.js</a></td>
                <td>After getting the brewery information, this helped me calculate roughly how many beers I will need to scrape.<br><br>
                Each brewery page will have a list of all of it's beers by name, style, percentage of alcohol (ABV), number of ratings, and overall score.
                <br><br>After I scraped each page, I created a unique JSON file for each brewery. This was to get around git hub file upload limits.</td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/extract_style.js">extract_style.js</a></td>
                <td>This script looked though all of the brewery JSON files and extracted the styles for each beer. I then streamed the unique styles to the terminal and piped the output to a JSON file</td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_styles.js">scrape_styles.js</a></td>
                <td>From the styles JSON file, I was able to generate a list of links to scrape the descriptions for all of the styles within my dataset. I scraped the style descriptions for each style present in my dataset.</td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/extract_flat_beer.js">extract_flat_beer.js</a></td>
                <td>This script goes through all of the brewery JSON files and create a flat JSON file of all of the beer JSON objects. This for me to be able to push the data into a database.</td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/extract_rating_counts.js">extract_rating_counts.js</a></td>
                <td>This script reads through my brewery JSON files and generates summary statistics regarding the total number of reviews that I could possibly scrape.</td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_breweries_lat_long.js">scrape_breweries_lat_long.js</a></td>
                <td>This script utilized the <a href="https://opencagedata.com/api">OpenCage Geocoder API</a> to </td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_beer_html.js">scrape_beer_html.js</a></td>
                <td>This script contains a module I wrote for scraping beer review scores with and without review text from Beer Advocate.<br><br>The structure of the HTML for these reviews was incredibly difficult to scrape given that some reviews only had an overall score, a set of scores, or scores with a text review. Additionally, when review text was present, it was structured between elements which makes it difficult to scrape without getting text from other elements within the HTML.<br><br>While using <a href="https://en.wikipedia.org/wiki/XPath">XPath selectors</a> is a standard work around, the variable nature of the HTML structure made it problematic to utilize.<br><br>My work around was to grab the text in a way that I could preserve the original structure of the HTML and convert the text nodes into a list/array. Because the overall score would always be at the top and the username and the date the review was posted would always be at the bottom of the HTML structure, I would search and filter the text nodes in between in order to determine what they were. I then mapped these values to a JSON object and return a list of these JSON objects for processing.</td>
            </tr>
            <tr>
                <td><a href="https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_beers.js">scrape_beers.js</a></td>
                <td>This script would query my database and utilize the scrape_beer_html.js module to scrape beer reviews as well as beer descriptions and availability from Beer Advocate. Once the desired information was scraped, it would be saved to a Postgres database.<br><br> I set up this script to prioritize scraping beers closest to Southern California.</td>
            </tr>
        </table>
    </li>
</ol>

### 3. Scrubbing data

Scrubbing data is still technically in process; however, from the data.world datasets, I removed null values and 

### 3. Exploring data

### 4. Modeling data

### 5. Interpreting data

### 6. Further Exploration
    - Looking at network effects
    - Do a sanity check to make sure that you can deliver your project on time
    - Build a REST API
    - Build a GraphQL endpoint