# Beer Recommender

[Current progress is located here](https://warm-plateau-97950.herokuapp.com/).

# Data Science Opportunity

Craft beer retail sales for 2017 resulted in [$26 billion dollars in total sales in the United States alone](https://www.statista.com/topics/1806/craft-beer-in-the-us/).

Providing a recommendation engine based on latitude and long


# Current Timeline

**9/30** - Have a plan for scraping URL's
    - Review [Terraform](https://www.hashicorp.com/products/terraform)
    - Review [Amazon Simple Queue](https://aws.amazon.com/sqs/)
    	- [Terraform config for Amazon Simple Queue](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html)
    - Calculate costs of AWS/Terraform for scraping/parallelization of resources
    - Review [AWS Lambda for use as a proxy](https://github.com/dan-v/awslambdaproxy)
    	- [Terraform config for AWS Lambda](https://www.terraform.io/docs/providers/aws/r/lambda_function.html)
**10/3** - Complete as much initial EDA as possible, create a progress report
**10/7** - Have a Database up and running and accessible via the web
    - Figure out what kind of front-end makes sense
**10/10** - 
**10/14** - Make Database Accessible from outside resources
    - Build a REST API
    - Build a GraphQL endpoint (optional)
**10/17** - Complete Technical Write-up
**10/21** - Finish Project Deliverables
	- Clean README
	- Clean Notebook
	- Data Dictionary
	- Some front-end for the App