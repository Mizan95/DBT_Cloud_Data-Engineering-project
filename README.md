## Introduction
In Azure Data Factory I built a pipeline pipelining data from onPrem SQL server to Bronze Data Lake container.

Using Databricks and SQL scripts, I  copied all tables into Unity Catalog bronze folder.

Using DBT, I built staging models and moved the data into silver folder in Databricks unity catalog.

Then, I made two data marts: Sales and Product. Both these data marts were built in the gold folder in Databricks unity catalog.

- pipeline diagram
- security best practices such as Azure Key Vault

## Tools I used


## ETL Data Workflow on Medallion Architecture
- image of data factory pipeline

## Conclusion


---------------------------
## Notes:

Staging folder contains data cleansing activty bronze --> silver

- creation of macro
- setting up project yml
- creation of staging sql files
  - data cleansing all column headers (using Jinja)
  - in Product model, transforms decimal numbers to two decimal points for the columns containing float numbers

## mart folder silver --> gold

### sales mart

- creating fct_sales table by inner joining stg_salesorderheader and stg_salesorderdetail models
- creating address and customer dimension tables
- creating customer and address bridge table to solve many-to-many relationship between address and customer dimension tables
- adding sales mart schema in dbt_project.yml file

### product mart

- creating dimension tables: product, product category, product description, product model
- creating product model and product description bridge table to solve many-to-many relationship between product model and product description dimension tables
- configuring dimension tables, bridge tables and their relationships in the product.yml file
- adding product mart schema in dbt_project.yml file

- creating dbt docs

### Automation


---

Welcome to your new dbt project!

### Using the starter project

Try running the following commands:

- dbt run
- dbt test

### Resources:

- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
