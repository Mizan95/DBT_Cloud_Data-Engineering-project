# DBT Data Engineering Project

## Introduction
In this DBT data engineering pipeline project, I set out to build and automate a data pipeline moving data from an onPrem SQL server to Databricks Unity Catalog. Then, by using DBT on Medallion Archtecture  perform transformations and create two data marts: Sales and Product. At the end of the pipeline, the resultant data marts were analysed via Power BI.

**Key Points of Note are below**:

- Best practices of enterprise security and governance were used in the form of storing secrets in Azure Keyvault and Azure Entra ID.

- A maintainable workflow was also used in the form of pipeline parameters for values such as DBT account ID and Job ID.

- The pipeline was one of ELT as opposed to ETL as the data was loaded into Databricks Unity Catalog first before being transformed with DBT.

- I performed the pipeline orchestration using Azure Data Factory.

- To recreate an enterprise environment, I used Microsoft Hyper-V to create an isolated virtual machine to house the project.

- I used the public Microsoft dataset named 'Adventure Works 2025'. This is a fictional dataset which represents sales data of a sports retailer called Adventure Works.


The full data pipeline diagram can be seen below:

![](assets\Screenshot_data-pipeline.png)


The Azure Data Factory pipeline can also be seen below:
![](assets/Screenshot_datafactory-pipeline.png)


### Brief Explanation of Pipeline
The pipeline ingested data from an on-prem SQL database into Azure Data Lake. Then, via a SQL script it was loaded into Databricks Unity Catalog in a Bronze container. Then, via a web activity a DBT access token was retrieved from Azure Keyvault and the DBT transformation and data marts job was run via another web activity by accessing the DBT API.  

The transformation job was perfomed on the data in the Databricks Bronze container.  

Lastly, an Until activity was used to poll the DBT API every 20 seconds to check if the DBT transformation and data marts job was complete returning either a success or fail message.  
On fail, the pipeline stopped running. On success, the transformed data were loaded into a Silver container in Databricks Unity Catalog and the two data marts were loaded into their respective Gold containers. Thus, allowing easy access for different business stakeholders.


-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*


Medallion Archtecture

Using Databricks and SQL scripts, I  copied all tables into Unity Catalog bronze folder.

Using DBT, I built staging models and moved the data into silver folder in Databricks unity catalog.

Then, I made two data marts: Sales and Product. Both these data marts were built in the gold folder in Databricks unity catalog.




- security best practices such as Azure Key Vault, maintainability with using pipeline parameters

## Tools I used
- **DBT Cloud** - to perform modular transformations and build Sales and Product data marts using models and macros which were then loaded back into Databricks Unity Catalog.

- **Azure Databricks** - the platform to load the data into Unity Catalog in the ELT process.

- **Azure Data Factory** - to orchestrate the ELT pipeline

- **Azure Data Lake** - to act as a bridge between Microsoft SQL Server and Databricks Unity Catalog.

- **Azure Entra ID** - to securely store DBT and Databricks API tokens and programmatically use these in the pipeline for best practice in security and governance.

- **Microsoft SQL Server** - the source on-Prem SQL database management system that initially held the data.

- **Microsoft Power BI** - to visually analyse the data from Azure Synapse Analytics using Star Schema method

- **Microsoft Hyper-V** - to recreate an enterprise environment by creating an isolated virtual machine to house the project.

## Detailed Explantion of Data Pipeline
For reference, the full data pipeline diagram can be seen below:

![](assets\Screenshot_data-pipeline.png)


The Azure Data Factory pipeline can also be seen below:
![](assets/Screenshot_datafactory-pipeline.png)

Link to dbt macros, models, staging --> silver, marts --> gold. 


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
