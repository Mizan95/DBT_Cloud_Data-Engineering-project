-- This file creates a business ready product description dim table for product analyst teams
-- it references the stg_productdescription table (model)


WITH productdescription AS (
    SELECT * FROM {{ ref('stg_productdescription') }}
)

SELECT
    ProductDescriptionID,
    Description,
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM productdescription