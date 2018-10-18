# Brew Recommender

[Current progress is located here](https://warm-plateau-97950.herokuapp.com/).

[Application Github is located here](https://github.com/rajangdavis/ba_scrape)

## Data Science Opportunity

Craft beer sales for 2017 resulted in [$26 billion dollars in total sales in the United States alone](https://www.statista.com/topics/1806/craft-beer-in-the-us/).

Because of this growing trend, the number of breweries has steadily [increased 15.5% over the past 6 years](https://www.brewersassociation.org/statistics/number-of-breweries/).

As the number of breweries increases, the ability for consumers to make decisions about what beer they purchase becomes full of noise. There is some discussion that [the abundance of craft beer can fatigue beer enthusiasts](https://vinepair.com/articles/craft-beers-post-snob-era-is-here/).

To me, providing good, *actionable* recommendations for beer is crucial for alleviating this fatigue. 

[There is prior work with beer recommendation systems](http://www.recommend.beer/analysis/); however, providing a recommendation system that can recommend beers a user may like from breweries that are near by adds tremendous value in that a user can act on the recommendation provided.
    
## Technical Report

### 0. Data Dictionary and Features


### 1. Obtaining data

I obtained publicly available datasets from [data.world](data.world) and scraped Beer Advocate for beer, brewery, beer style, and review information. I acquired geographic information using the addresses provided by Beer Advocate and utilizing the [OpenCage Geocoder API](https://opencagedata.com/api) for deriving coordinates for each brewery.
<br>
<br>Here is a break down of the datasets and the scripts I used for scraping beer advocate data:
    <ol>
        <li>Datasets from [data.world](data.world):
            <ol>
                <li>[1.5 million reviews from Beer Advocate with scores only](https://data.world/socialmediadata/beeradvocate)
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
                    [528,870 Reviews from Beer Advocate some of which had text reviews](https://data.world/petergensler/beer-advocate-reviews)
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
            I scraped [Beer Advocate](beeradvocate.com) using the [axios](https://www.npmjs.com/package/axios) and [cheerio](https://cheerio.js.org/) libraries from the NodeJS ecosystem. [Scripts are located here](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts). Here is a brief explanation of what each script does:
            <table>
                <tr>
                    <th>Script Name</th>
                    <th>What does it do</th>
                </tr>
                <tr>
                    <td>[scrape_ba.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_ba.js)</td>
                    <td>This was the initial script I created to scrape Beer Advocate.com. I grabbed all of the [places by state hyperlinks](https://www.beeradvocate.com/place/directory/0/US/). From some investigation, I knew that appending '?c_id=US&s_id=[STATE]&brewery=Y' to the URL would filter the places by breweries by state.
                    <br><br>Once the brewery list for a state is retrieved, I have the script look at the number of results and calculate the number of subsequent pages to queue up the next set of links to scrape. The script then grabs all of the brewery location inforamtion and number of beers.
                    </td>
                </tr>
                <tr>
                    <td>[scrape_brewery_page.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_brewery_page.js)</td>
                    <td>After getting the brewery information, this helped me calculate roughly how many beers I will need to scrape.<br><br>
                    Each brewery page will have a list of all of it's beers by name, style, percentage of alcohol (ABV), number of ratings, and overall score.
                    <br><br>After I scraped each page, I created a unique JSON file for each brewery. This was to get around git hub file upload limits.</td>
                </tr>
                <tr>
                    <td>[extract_style.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/extract_style.js)</td>
                    <td>This script looked though all of the brewery JSON files and extracted the styles for each beer. I then streamed the unique styles to the terminal and piped the output to a JSON file</td>
                </tr>
                <tr>
                    <td>[scrape_styles.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_styles.js)</td>
                    <td>From the styles JSON file, I was able to generate a list of links to scrape the descriptions for all of the styles within my dataset. I scraped the style descriptions for each style present in my dataset.</td>
                </tr>
                <tr>
                    <td>[extract_flat_beer.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/extract_flat_beer.js)</td>
                    <td>This script goes through all of the brewery JSON files and create a flat JSON file of all of the beer JSON objects. This for me to be able to push the data into a database.</td>
                </tr>
                <tr>
                    <td>[extract_rating_counts.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/extract_rating_counts.js)</td>
                    <td>This script reads through my brewery JSON files and generates summary statistics regarding the total number of reviews that I could possibly scrape.</td>
                </tr>
                <tr>
                    <td>[scrape_breweries_lat_long.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_breweries_lat_long.js)</td>
                    <td>This script utilized the [OpenCage Geocoder API](https://opencagedata.com/api) to </td>
                </tr>
                <tr>
                    <td>[scrape_beer_html.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_beer_html.js)</td>
                    <td>This script contains a module I wrote for scraping beer review scores with and without review text from Beer Advocate.<br><br>The structure of the HTML for these reviews was incredibly difficult to scrape given that some reviews only had an overall score, a set of scores, or scores with a text review. Additionally, when review text was present, it was structured between elements which makes it difficult to scrape without getting text from other elements within the HTML.<br><br>While using [XPath selectors](https://en.wikipedia.org/wiki/XPath) is a standard work around, the variable nature of the HTML structure made it problematic to utilize.<br><br>My work around was to grab the text in a way that I could preserve the original structure of the HTML and convert the text nodes into a list/array. Because the overall score would always be at the top and the username and the date the review was posted would always be at the bottom of the HTML structure, I would search and filter the text nodes in between in order to determine what they were. I then mapped these values to a JSON object.</td>
                </tr>
                <tr>
                    <td>[scrape_beers.js](https://github.com/rajangdavis/ba_scrape/tree/master/scrape_extract_scripts/scrape_beers.js)</td>
                    <td>This script would query my database and utilize the scrape_beer_html.js module to scrape beer reviews as well as beer descriptions and availability from Beer Advocate. Once the desired information was scraped, it would be saved to a Postgres database.</td>
                </tr>
            </table>
        </li>
    </ol>

### 2. Scrubbing data

Scrubbing data is still in process; however, from the data.world datasets, I removed null values and 

### 3. Exploring data

### 4. Modeling data

### 5. Interpreting data

### 6. Further Exploration
Looking at network effects
- **10/10** - Build front-end or use Twilio
    - Do a sanity check to make sure that you can deliver your project on time

- **10/14** - Make Database Accessible from outside resources
    - Build a REST API
    - Build a GraphQL endpoint