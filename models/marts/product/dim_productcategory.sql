-- This file creates a business ready product category dim table for product analyst teams
-- it references the stg_productcategory table (model)


WITH productcategory AS (
    SELECT * FROM {{ ref('stg_productcategory') }}
)

SELECT
    ProductCategoryID,
    ParentProductCategoryID,
    Name,
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM productcategory