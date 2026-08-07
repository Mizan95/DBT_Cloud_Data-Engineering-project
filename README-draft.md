# DBT Data Engineering Project

## Introduction
In this DBT data engineering pipeline project, I set out to build and automate a data pipeline moving data from an onPrem SQL server to Databricks Unity Catalog. Then, by using DBT on Medallion Architecture  perform transformations and create two data marts: Sales and Product. At the end of the pipeline, the resultant data marts were analysed via Power BI.

**Key Points of Note are below**:

- Best practices of enterprise security and governance were used in the form of storing secrets in Azure Keyvault and using Azure Entra ID.

- A maintainable workflow was also used in the form of pipeline parameters for values such as DBT account ID and Job ID.

- The pipeline was one of ELT as opposed to ETL as the data was loaded into Databricks Unity Catalog first before being transformed with DBT.

- I performed the pipeline orchestration using Azure Data Factory.

- To recreate an enterprise environment, I used Microsoft Hyper-V to create an isolated virtual machine to house the project.

- I used the public Microsoft dataset named 'Adventure Works 2025'. This is a fictional dataset which represents sales data of a sports retailer called Adventure Works.


The full data pipeline diagram can be seen below:

![](assets/Screenshot_data-pipeline.png)


The Azure Data Factory pipeline can also be seen below:
![](assets/Screenshot_datafactory-pipeline.png)


### Brief Explanation of Pipeline
The pipeline ingested data from an on-prem SQL database into Azure Data Lake. Then, via a SQL script it was loaded into Databricks Unity Catalog in a Bronze container. Then, via a web activity a DBT access token was retrieved from Azure Keyvault and the DBT transformation and data marts job was run via another web activity by accessing the DBT API.  

The transformation and data marts job was performed on the data in the Databricks Bronze container.  

Lastly, an Until activity, alongside further nested activities, were used to poll the DBT API every 20 seconds to check if the DBT transformation and data marts job was complete. This returned either a success or fail message.  
On fail, the pipeline stopped running.  
On success, the transformed data was loaded into a Silver container in Databricks Unity Catalog and the two data marts were loaded into their respective Gold containers. This allowed easy access for different business stakeholders.


-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


Medallion Architecture

Using Databricks and SQL scripts, I  copied all tables into Unity Catalog bronze folder.

Using DBT, I built staging models and moved the data into silver folder in Databricks unity catalog.

Then, I made two data marts: Sales and Product. Both these data marts were built in the gold folder in Databricks unity catalog.

security best practices such as Azure Key Vault, maintainability with using pipeline parameters

## Tools I used
- **DBT Cloud** - to perform modular transformations and build Sales and Product data marts using models and macros which were then loaded back into Databricks Unity Catalog.

- **Azure Databricks** - the platform to load the data into Unity Catalog in the ELT process.

- **Azure Data Factory** - to orchestrate the ELT pipeline

- **Azure Data Lake** - to act as a bridge between Microsoft SQL Server and Databricks Unity Catalog.

- **Azure Entra ID** - to securely store DBT and Databricks API tokens and programmatically use these in the pipeline for best practice in security and governance.

- **Microsoft SQL Server** - the source on-Prem SQL database management system that initially held the data.

- **Microsoft Power BI** - to visually analyse the data from Azure Synapse Analytics using Star Schema method

- **Microsoft Hyper-V** - to recreate an enterprise environment by creating an isolated virtual machine to house the project.

## Detailed Explanation of Data Pipeline
For reference, the full data pipeline diagram can be seen below:

![](assets/Screenshot_data-pipeline.png)


The Azure Data Factory pipeline can also be seen below:
![](assets/Screenshot_datafactory-pipeline.png)

1. Ingestion (On-Prem to Bronze):
   * Azure Data Factory ingests data from SQL Server using a Lookup activity.
   * Using a a ForEach activity, data is extracted raw and converted to Parquet files in the Bronze Storage Container in Data Lake.

2. The data is then loaded into Databricks Unity Catalog using SQL scripts (highly efficient compared to Python scripts, give some technical detail here)

3. Using a Web activity, a DBT token is retrieved from Azure Key Vault with an API call

4. Using a Web activity, the DBT transformation job is initiated by an API call. This uses the Token from the previous step. build: transform, data marts, details in DBT walkthrough section

5. Then, the DBT run ID is stored inside a pipeline variable.
 
6. Using an Until activity, there are 4 nested activities:
   1. A Wait activity waits for 20 seconds
   2. A Web activity (get_dbt_run) retrieves the DBT run ID and polls the DBT API checking if the DBT job was successful or failed.
   3. The pipeline variable job_status is set here with some conditional logic. The logic is where if the output of get_dbt_run (the previous step) is 10, is sets the job_status variable as the string 'false', otherwise it sets it as the string 'true'.
   4. An If activity which outlines the pipeline logic if the job is failed. This contains 2 nested activities:
      1. If the job is successful, the pipeline stops polling the DBT API.
      2. If the job is failed, the pipeline stops completely and returns an error message.

- Link to dbt macros, models, staging --> silver, marts --> gold. 

## DBT walkthrough
- Include screenshots of DBT models etc.



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
