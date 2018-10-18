# Brew Recommender

[Current progress is located here](https://warm-plateau-97950.herokuapp.com/).

[Application Github is located here](https://github.com/rajangdavis/ba_scrape)

# Data Science Opportunity

Craft beer sales for 2017 resulted in [$26 billion dollars in total sales in the United States alone](https://www.statista.com/topics/1806/craft-beer-in-the-us/).

Because of this growing trend, the number of breweries has steadily [increased 15.5% over the past 6 years](https://www.brewersassociation.org/statistics/number-of-breweries/).

As the number of breweries increases, the ability for consumers to make decisions about what beer they purchase becomes full of noise. There is some discussion that [the abundance of craft beer can fatigue beer enthusiasts](https://vinepair.com/articles/craft-beers-post-snob-era-is-here/).

To me, providing good, *actionable* recommendations for beer is crucial for alleviating this fatigue. 

[There is prior work with beer recommendation systems](http://www.recommend.beer/analysis/); however, providing a recommendation system that can recommend beers a user may like from breweries that are near by adds tremendous value in that a user can act on the recommendation provided.

# Current Timeline

- **9/30** I ended up scraping Beer Advocate :/
	- ~~Have a plan for scraping URL's
	- ~~Review [scraping services](https://www.scrapehero.com/web-scraping-cloud-providers/)
	- ~~Review [ScrapingHub](https://scrapinghub.com/scrapy-cloud)
		- ~~[Crawlera *might* be the best solution](https://scrapinghub.com/crawlera)
    - ~~Calculate costs of AWS/Terraform for scraping/parallelization of resources
    - ~~Review [Terraform](https://www.hashicorp.com/products/terraform)
    - ~~Review [Amazon Simple Queue](https://aws.amazon.com/sqs/)
    	- ~~[Terraform config for Amazon Simple Queue](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html)
    - ~~Review [AWS Lambda for use as a proxy](https://github.com/dan-v/awslambdaproxy)
    	- ~~[Terraform config for AWS Lambda](https://www.terraform.io/docs/providers/aws/r/lambda_function.html)
- **10/7** - ~~Have a Database up and running and accessible via the web

### To do
- **10/3** - Complete as much initial EDA as possible, create a progress report
- **10/17** - Complete Technical Write-up
- **10/21** - Finish Project Deliverables
	- Clean README
	- Clean Notebook
	- Data Dictionary
	- Some front-end for the App

### Another time
- **10/10** - Build front-end or use Twilio
	- Do a sanity check to make sure that you can deliver your project on time

- **10/14** - Make Database Accessible from outside resources
    - Build a REST API
    - Build a GraphQL endpoint
    
# Technical Report

### 0. Features


### 1. Obtaining data

I obtained data in a few different flavors:
    1. Datasets from data.world
        i. 
        ii.
    2. Via Scraping using the axios and Cheerio libraries NodeJS
        i. [Scripts are located here](https://github.com/rajangdavis/ba_scrape)
    3.

### 2. Scrubbing data

### 3. Exploring data

### 4. Modeling data

### 5. Interpreting data

### 6. Further Exploration
Looking at network effects