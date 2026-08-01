-- This file creates a business ready bridge table bridging product model dim table and product description table for product analyst teams
-- it references the stg_productmodelproductdescription table (model)


WITH productmodelproductdescription AS (
    SELECT * FROM {{ ref('stg_productmodelproductdescription') }}
)

SELECT
    ProductModelID,
    ProductDescriptionID,
    Culture,
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM productmodelproductdescription