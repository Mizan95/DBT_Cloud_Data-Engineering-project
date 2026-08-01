-- This file creates a business ready product model dim table for product analyst teams
-- it references the stg_productmodel table (model)


WITH productmodel AS (
    SELECT * FROM {{ ref('stg_productmodel') }}
)

SELECT
    ProductModelID,
    Name,
    CURRENT_TIMESTAMP() AS dbt_transformed_at

FROM productmodel