## Notes:

Staging folder contains data cleansing activty bronze --> silver
- creation of macro
- setting up project yml
- creation of staging sql files
    - data cleansing all column headers (using Jinja)
    - in Product model, transforms decimal numbers to two decimal points for the columns containing float numbers

mart folder silver --> gold
- sales mart
- creating fct_sales table by inner joining stg_salesorderheader and stg_salesorderdetail models
- creating address and customer dimension tables
- creating customer and address bridge table to solve many-to-many relationship between address and customer dimension tables
- configuring dimension tables and bridge tables (and their relationships) in the sales.yml files

- product mart




-----------------
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
