-- This file creates a business ready product dim table for product analyst teams
-- it references the stg_product table (model)


WITH product AS (
    SELECT * FROM {{ ref('stg_product') }}
)

SELECT
    ProductID,
    Name,
    ProductNumber,
    ProductCategoryID,
    ProductModelID,
    Color,
    StandardCost,
    ListPrice,
    CURRENT_TIMESTAMP() AS dbt_transformed_at
FROM product
